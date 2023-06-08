package;

import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;
import flixel.FlxG;

/**
 * handles save data initialization
*/
class SaveDataHandler
{
    public static function initSave()
    {
      if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;
		
		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.eyesores == null)
			FlxG.save.data.eyesores = true;

		if (FlxG.save.data.donoteclick == null)
			FlxG.save.data.donoteclick = false;

		if (FlxG.save.data.newInput != null && FlxG.save.data.lastversion == null)
			FlxG.save.data.lastversion = "pre-beta2";
		
		if (FlxG.save.data.newInput == null && FlxG.save.data.lastversion == null)
			FlxG.save.data.lastversion = "beta2";
		
		if (FlxG.save.data.songPosition == null)
			FlxG.save.data.songPosition = true;
		
		if (FlxG.save.data.noteCamera == null)
			FlxG.save.data.noteCamera = true;
		
		if (FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0;

		if (FlxG.save.data.selfAwareness == null)
			FlxG.save.data.selfAwareness = true;
		
		if (FlxG.save.data.wasInCharSelect == null)
			FlxG.save.data.wasInCharSelect = false;

		if (FlxG.save.data.charactersUnlocked == null)
			FlxG.save.data.charactersUnlocked = ['bf', 'bf-pixel'];

		if (FlxG.save.data.disableFps == null)
			FlxG.save.data.disableFps = false;
		
		if (FlxG.save.data.masterWeekUnlocked == null)
			FlxG.save.data.masterWeekUnlocked = false;

		if (FlxG.save.data.enteredTerminalCheatingState == null)
			FlxG.save.data.enteredTerminalCheatingState = false;
			
		if (FlxG.save.data.hasSeenCreditsMenu == null)
			FlxG.save.data.hasSeenCreditsMenu = false;
		
		if (FlxG.save.data.songBarOption == null)
			FlxG.save.data.songBarOption = 'ShowTime';

		if (FlxG.save.data.noRating == null)
			FlxG.save.data.noRating = true;

		if (FlxG.save.data.moreScoreInfo == null)
			FlxG.save.data.moreScoreInfo = true;

		if (FlxG.save.data.comboFlash == null)
			FlxG.save.data.comboFlash = false;

		if (FlxG.save.data.comboSound == null)
			FlxG.save.data.comboSound = false;

		if (FlxG.save.data.globalAntialiasing == null)
			FlxG.save.data.globalAntialiasing = true;

		if (FlxG.save.data.freeplayCuts == null)
			FlxG.save.data.freeplayCuts = false;

	    	if (FlxG.save.data.allfreeplaysongsbeat == null)
			FlxG.save.data.freeplayCuts = false;
	    
		if (FlxG.save.data.barColors == null)
			FlxG.save.data.barColors = false;

		if (FlxG.save.data.freeplayMusic == null)
			FlxG.save.data.freeplayMusic = true;

		if (FlxG.save.data.longAssBar == null)
			FlxG.save.data.longAssBar = true;
    }
}
