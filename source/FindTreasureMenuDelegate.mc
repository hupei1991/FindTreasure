using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class FindTreasureMenuDelegate extends Ui.MenuInputDelegate {

    function onMenuItem(item) {
        if (item == :item_1) {
            Sys.println("Compare whos score is higher!");
        }
    }

}