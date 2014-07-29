$(function() {
	console.log(gon.melodic_contour);
	var pitchRangeChart = c3.generate({
	        bindto: "#note_count",
	        data: {
	          columns: 
	            gon.pitch_range_data
	            // gon.data2
	          ,
	          axes: {
	            pitch_range_data: 'y'
	            // data2: 'y2',
	          },
	          type: "bar"
	        },
	        axis: {
	    
	          y: {
	            label: {
	              text: 'Range (octaves)',
	              position: 'outer-middle'
	            }
	          },
	        },
	        tooltip: {
	//          enabled: false
	        },
	        zoom: {
	//          enabled: true
	        },
	        subchart: {
	//          show: true
	        }
	      });

	// var melodicCountourChart = c3.generate({

	// 	bindto: "#melodic_contour",
	//     data: {
	//         columns: gon.melodic_contour,
	//         type: 'spline'
	//     },
	//     axis: {
	    	
	//     	x: {
	//     		label: {
	//     			text: 'Measures'
	//     		}
	//     	},

	//     	y: {
	//     		label: {
	//     			text: 'Pitch',
	//     			position: 'outer-middle'
	//     		}
	//     	},
	//     }
	// });
var chart = c3.generate({
	bindto: "#melodic_contour",
    data: {
        // xs: {
        //     soprano: 'Soprano',
        //     alto: 'Alto',
        //     piano: 'Piano'
        // },
        // iris data from R
        columns: gon.melodic_contour,
        type: 'scatter'
    },
    axis: {
        x: {
            label: 'Sepal.Width',
            tick: {
                fit: false
            }
        },
        y: {
            label: 'Petal.Width'
        }
    }
});
});