require "rexml/document"
require "active_support/core_ext"

class Score < ActiveRecord::Base
  belongs_to :user
  has_many :parts
  has_many :measures, through: :parts
  has_many :notes, through: :measures

  validates :title, presence: true
  validates :user, presence: true
  validates :composer, presence: true

  mount_uploader :music_xml, OriginalScorePhotoUploader

  after_create :create_parts

  def self.search(search)
    @scores = where('title LIKE ? OR composer LIKE ? ', "%#{search}%", "%#{search}%")
  end

  def create_parts
    $hash = Hash.from_xml(music_xml.file.read)

    parts = $hash["score_partwise"]["part_list"]["score_part"]
    parts = [parts] if parts.is_a?(Hash)

    parts.each do |part|
      self.parts << Part.create(instrument_name: part["part_name"], part_number: part["id"][1..-1].to_i)
    end
  end

  def total_note_count
    self.notes.count
  end

  def avg_notes_per_measure
    (total_note_count / self.measures.count.to_f).round(2)
  end

  def self.avg_total_note_count
    total = 0
    Score.all.each {|score| total += score.total_note_count}
    (total / Score.all.length.to_f).round(2)
  end

  def self.avg_notes_per_measure
    total = 0
    Score.all.each {|score| total += score.avg_notes_per_measure}
    (total / Score.all.length.to_f).round(2)
  end

  def get_range
    sci_notation_array = self.notes.map{|note| note.sci_notation}.compact.map{|sci_notation| sci_notation.reverse.first.to_i}.sort
    range = sci_notation_array.last - sci_notation_array.first
    [self.title, range]
  end

  def get_frequencies
    part_frequencies = []
    self.parts.each do |part|
      sci_notations = part.notes.map{|note| note.sci_notation}.compact.map{|note| note.downcase}
      part_frequencies << [part.instrument_name] +sci_notations.map{|note| NoteFrequencies.frequency_from_name(note)}

    end
    part_frequencies
  end

  def self.get_ranges
    ranges = []
    Score.all.each {|score| ranges << score.get_range}
    ranges
  end

  # def sort_scientific_notation
  #   pitches = []
  #   self.notes.each {|note| pitches <<  note.sci_notation }
  #   pitches = pitches.compact
  #   pitches.join("").split("")
  #   Hash[*pitches.reverse]
  # end

end

