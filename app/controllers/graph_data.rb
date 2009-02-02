class GraphData < Application

  def loan
    
    <<-JSON
{
  "y_legend":{
    "text":   "Time of day",
    "style": "{color: #736AFF;}"
  },

  "elements":[
    {
      "type":      "line_dot",
      "colour":    "#736AFF",
      "text":      "Avg. wave height (cm)",
      "font-size": 10,
      "width":     1,
      "dot-size":  1,
      "halo-size": 0,
      "values" :   [1.5,1.69,1.88,2.06,2.21,2.34,2.43,2.48,2.49,2.47,2.40,2.30,2.17,2.01,1.83,1.64,1.44,1.24,1.05,0.88,0.74,0.62,0.54,0.50,0.50,0.54,0.61,0.72,0.86,1.03,1.22,1.41,1.61,1.81,1.99,2.15,2.29,2.39,2.46,2.49,2.48,2.44,2.35,2.23,2.08]
    }
  ],

  "x_axis":{
    "labels":["2:00am","2:10","2:20","2:30","2:40","2:50",
              "3:00am","3:10","3:20","3:30","3:40","3:50",
              "4:00am","4:10","4:20","4:30","4:40","4:50",
              "5:00am","5:10","5:20","5:30","5:40","5:50",
              "6:00am","6:10","6:20","6:30","6:40","6:50",
              "7:00am","7:10","7:20","7:30","7:40","7:50",
              "8:00am","8:10","8:20","8:30","8:40","8:50",
              "9:00am","9:10","9:20"]
  },

/*

x_label_style = 13,0x9933CC,0,6
y_label_style = none
bg_colour = 0xDFFFDF

*/

  "y_axis":{
    "max":   3
  }

}
    JSON
  end

  def client
    <<-JSON
{
  "series":
    [{
      "items":4,
      "steps":1,
      "options":{"date_label_formatter":"%b %Y","date_key_formatter":"%Y-%m","items":4,"title":"Media"},
      "json_class":"OpenFlashChartLazy::Serie",
      "title":"Media",
      "keys":[],
      "max":0,
      "values":[40000,10000,50000,40000],
      "min":0,
      "labels":["tv","internet","magazines","other"],
      "data":[["tv",40000],["internet",10000],["magazines",50000],["other",40000]]
    }],
  "elements":[{"text":"Media","type":"line","values":[40000,10000,50000,40000]}],
  "x_axis":
    {
      "colour":"#808080",
      "grid-colour":"#A0A0A0",
      "labels":{"colour":"#909090","3d":10,"labels":["tv","internet","magazines","other"]}
    },
    "y_axis":
    {
      "steps":25000,
      "max":80000,
      "colour":"#808080",
      "min":0,
      "grid-colour":"#A0A0A0"
    },
  "title":{"text":"#{params[:resource]}"},
  "bg_colour":"#ffffff"
}
    JSON
  end
  
end
