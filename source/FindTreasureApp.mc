using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Position as Gps;

var myScore = new Score();
var find = new Find();
var nor = 0;
var wes = 0;

class FindTreasureApp extends App.AppBase {
    //! onStart() is called on application start up
    
    function onStart() {
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new FindTreasureView(), new FindTreasureDelegate() ];
    }

}

class Find{
	hidden var findOrNot;
	function initialize(){
		findOrNot = 0;
	}
	
	function getResult(){
		return findOrNot;
	}
	function setResult(aFindOrNot){
		findOrNot = aFindOrNot;
	}
}

class Score{
	hidden var score;
	function initialize(){
		score = 0;
	}
	
	function getScore(){
		return score;
	}
	
	function setScore(aScore){
		score = aScore;
	}
}

class FindTreasureDelegate extends Ui.BehaviorDelegate {

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new FindTreasureMenuDelegate(), Ui.SLIDE_UP);
    }

}