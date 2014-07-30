require 'spec_helper'

describe Score do
	let(:music_xml_1) do
		File.open("spec/test_scores/wario.xml")
	end

  let(:score) do
  	score = Score.create!(user_id: 1, 
  							 title: "wario's fat",
  							 composer: "Andy Principe",
  							 music_xml: music_xml_1)
  end

 	let(:music_xml_2) do
		File.open("spec/test_scores/africa.xml")
	end

  let(:score2) do
  	score2 = Score.create!(user_id: 1, 
  							 title: "Africa",
  							 composer: "Al Pachino",
  							 music_xml: music_xml_2)
  end

	# before(:each) do
	# 	@music_xml = File.open("spec/test_scores/wario.xml")
	# 	@score = Score.create!(user_id: 1, 
 #  							  title: "wario's fat",
 #  							  composer: "Andy Principe",
 #  							  music_xml: @music_xml)
	# end

	# after(:each) do
	# 	@music_xml.close
	# end

  subject { score }

  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:composer) }
  it { should respond_to(:music_xml) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:composer) }


  it { should belong_to(:user) }
  it { should have_many(:parts) }
  it { should have_many(:measures).through(:parts) }
  it { should have_many(:notes).through(:measures) }

  it "should return the score ID for the uploader" do
    expect(score.user_id).to eq 1
  end

  it "should return the score title " do
    expect(score.title).to eq "wario's fat"
  end

  it "should return the score composer" do
    expect(score.composer).to eq "Andy Principe"
  end

  xit "should create parts" do
  	score
  	before = Part.all.count
  	score.create_parts
  	after = Part.all.count
  	# p before
  	# p after
  	# File.close("spec/test_scores/wario.xml")
  	expect(after > before).to be_true
  end 

  it "should return the number of total notes in the score" do
  	score.total_note_count
  	expect(score.total_note_count).to eq(31)
  end

  it "should return search results for the score" do
  	score
  	expect(Score.search("wario").first.title).to eq("wario's fat")
  end

  it "should return search results for the composer" do
  	score
  	expect(Score.search("Andy").first.composer).to eq("Andy Principe")
  end 

  it "should return average notes per a measure metric agaist a particular score" do
  	expect(score.avg_notes_per_measure).to eq(3.88)
  end 

  it "should return average total notes metric against all scores" do
  	score
  	expect(Score.avg_total_note_count).to eq(988.0)
  end

  it "should return average notes per a measure metric against all scores" do
  	score
  	expect(Score.avg_notes_per_measure).to eq(4.42)
  end

  it "should return the range of the score" do
  	expect(score.get_range).to eq(["wario's fat", 1])
  end

  it "should return the range of all scores" do
  	score
  	expect(Score.get_ranges).to eq([["test", 4], ["wario's fat", 1]])
  end

end
