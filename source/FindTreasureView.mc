using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Position as Gps;
using Toybox.Math as Math;
using Toybox.Activity as Act;

class FindTreasureView extends Ui.View {

    var image;
    var flag;
    var range;
    var nor_max;
    var nor_min;
    var wes_max;
    var wes_min;
    var cent_x;
    var cent_y;
    var got_flag;
    
    function initialize(){
        Gps.enableLocationEvents(Gps.LOCATION_CONTINUOUS,method(:onPosition));
        flag = 0;
        got_flag = 0;
        //Toybox.System.println("dddd");
    }
    
    function onPosition(info){
    	if(flag == 0){
    		var arr = new [2];
    		//Toybox.System.println("!!!!!!!!!!!");
    		Toybox.System.println("Position " + info.position.toGeoString(Gps.GEO_DEG));
    		arr = info.position.toDegrees();
    		nor = arr[0];
    		wes = arr[1];
    		//Toybox.System.println(nor);
    		//Toybox.System.println(wes);
    		range = 0.0500;
    		nor_max = nor + range;
    		nor_min = nor - range;
    		wes_max = wes + range;
    		wes_min = wes - range;
    		
    		//change random number if have time
			if (nor_max > nor_min){
				//cent_x = Math.rand() % (nor_max-nor_min) + nor_min;
				cent_x = nor_min + (nor_max - nor_min)/2;
			}else{
				//cent_x = Math.rand() % (nor_min-nor_max) + nor_max;
				cent_x = nor_max + (nor_min - nor_max)/2;
			}
			if (wes_max > wes_min){
				cent_y = wes_min + (wes_max - wes_min)/2;
				//cent_y = Math.rand() % (wes_max-wes_min) + wes_min;
			}else{
				cent_y = wes_max + (wes_min - wes_max)/2;
				//cent_y = Math.rand() % (wes_min-wes_max) + wes_max;
			}
			//Toybox.System.println(cent_x);
    		//Toybox.System.println(test);
    		flag = 1;
    	}else{
    		Toybox.System.println("Position " + info.position.toGeoString(Gps.GEO_DEG));
    		if(got_flag == 0){
    			var arr1 = new [2];
    			arr1 = info.position.toDegrees();
    			var now_x = arr1[0];
    			var now_y = arr1[1];
    			if(Math.pow((now_x-cent_x),2) + Math.pow((now_y-cent_y),2) < Math.pow(range/5,2)){
    				find.setResult(1);
					
					//if( Act.info.elapsedDistance != null )
            		//{
            		//   var dist = Act.info.elapsedDistance * 0.000621371; //Meters to Miles
            		//}
            		//myScore.setScore(myScore.getScore()+10+dist);
    				myScore.setScore(myScore.getScore()+10);
    				got_flag = 1;
    			}
    		}
    		Ui.requestUpdate();
    	}

	}
	
    //! Load your resources here
    function onLayout(dc) {
        image = Ui.loadResource(Rez.Drawables.id_monkey);
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	var tmp;
    	var tmpString;
    	var found = "You found a treasure!";
        dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_WHITE);
        dc.clear();
        dc.drawBitmap(0, 0, image);
        dc.drawText(5, 20, Gfx.FONT_TINY, "Compete with friends", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(5, 65, Gfx.FONT_XTINY, "Your Score:", Gfx.TEXT_JUSTIFY_LEFT); 
        tmp = myScore.getScore();
       	//Toybox.System.println(tmp);
		tmpString = tmp.toString();
       	dc.drawText(5, 80, Gfx.FONT_XTINY, tmpString, Gfx.TEXT_JUSTIFY_LEFT);
       	if(find.getResult()){
       		dc.drawText(5, 140, Gfx.FONT_XTINY, found, Gfx.TEXT_JUSTIFY_LEFT);
       	}
    }

    //! Called when this View is removed from the screen. Save the
    //! state of your app here.
    function onHide() {
    }

}