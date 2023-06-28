package; // "Most hard-coded FNF mod ever!!!!!!!!!!" - p0kk0 on GameBanana(https://gamebanana.com/mods/43201?post=10328553)

import CreditsMenuState.CreditsText;
import TerminalCheatingState.TerminalText;
import flixel.graphics.frames.FlxFrame;
import flixel.graphics.FlxGraphic;
import flixel.addons.transition.Transition;
import flixel.group.FlxGroup;
import sys.FileSystem;
import flixel.util.FlxArrayUtil;
import flixel.addons.plugin.FlxScrollingText;
import Alphabet;
import flixel.addons.display.FlxBackdrop;
import openfl.display.ShaderParameter;
import openfl.display.Graphics;
import flixel.group.FlxSpriteGroup;
import lime.tools.ApplicationData;
import flixel.effects.particles.FlxParticle;
import hscript.Printer;
import openfl.desktop.Clipboard;
import flixel.system.debug.Window;
#if desktop
import sys.io.File;
import openfl.display.BitmapData;
#end
import flixel.system.FlxBGSprite;
import flixel.tweens.misc.ColorTween;
import flixel.math.FlxRandom;
import openfl.net.FileFilter;
import openfl.filters.BitmapFilter;
import Shaders.PulseEffect;
import Shaders.BlockedGlitchShader;
import Shaders.BlockedGlitchEffect;
import Shaders.DitherEffect;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import flash.system.System;
import flixel.util.FlxSpriteUtil;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.addons.effects.chainable.IFlxEffect;
#if desktop
import Discord.DiscordClient;
#end

#if windows
import sys.io.File;
import sys.io.Process;
import lime.app.Application;
#end

import flixel.system.debug.Window;
import lime.app.Application;
import openfl.Lib;
import openfl.geom.Matrix;
import lime.ui.Window;
import openfl.geom.Rectangle;
import openfl.display.Sprite;

import vlc.MP4Handler;

using StringTools;

class PlayState extends MusicBeatState
{
	public static var mania:Int = 0;

	public static var instance:PlayState;

	public static var curStage:String = '';
	public static var characteroverride:String = "none";
	public static var formoverride:String = "none";
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	public static var botPlay:Bool = false;
	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

	public var ExpungedWindowCenterPos:FlxPoint = new FlxPoint(0,0);

	public var dadCombo:Int = 0;
	public static var globalFunny:CharacterFunnyEffect = CharacterFunnyEffect.None;

	public var localFunny:CharacterFunnyEffect = CharacterFunnyEffect.None;

	public var dadGroup:FlxGroup;
	public var bfTrailGroup:FlxGroup;
	public var bfGroup:FlxGroup;
	public var gfGroup:FlxGroup;

	public static var ratingStuff:Array<Dynamic> = [
		['You Suck!', 0.2], //From 0% to 19%
		['Shit', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Bruh', 0.6], //From 50% to 59%
		['Meh', 0.69], //From 60% to 68%
		['Nice', 0.7], //69%
		['Good', 0.8], //From 70% to 79%
		['Great', 0.9], //From 80% to 89%
		['Sick!', 1], //From 90% to 99%
		['Perfect!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var darkLevels:Array<String> = ['bambiFarmNight', 'daveHouse_night', 'unfairness', 'bedroomNight', 'backyard',
	'scrappedbambiFarmNight', 'oldbambiFarmNight', 'bambiFarmNight2.5', 'daveHouse_night25'];
	public var sunsetLevels:Array<String> = ['bambiFarmSunset', 'daveHouse_Sunset', 'oldbambiFarmSunset', 'scrappedbambiFarmSunset',
	'bambiFarmSunset2.5'];

	public var stupidx:Float = 0;
	public var stupidy:Float = 0; // stupid velocities for cutscene
	public var updatevels:Bool = false;

	public var hasTriggeredDumbshit:Bool = false;
	var AUGHHHH:String;
	var AHHHHH:String;

	public static var curmult:Array<Float> = [1, 1, 1, 1];
	public static var curmultDefine:Array<Float> = [1, 1, 1, 1];

	public var curbg:BGSprite;
	public var pre3dSkin:String;
	#if SHADERS_ENABLED
	public static var screenshader:Shaders.PulseEffect = new PulseEffect();
	public static var lazychartshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
	public static var blockedShader:BlockedGlitchEffect;
	public var dither:DitherEffect = new DitherEffect();
	#end

	public var UsingNewCam:Bool = false;

	public var elapsedtime:Float = 0;

	public var elapsedexpungedtime:Float = 0;

	var focusOnDadGlobal:Bool = true;

	var funnyFloatyBoys:Array<String> = ['dave-angey', 'bambi-3d', 'expunged', 'bambi-unfair', 'exbungo',
	'dave-festival-3d', 'dave-3d-recursed', 'bf-3d', 'dave-angey-old', 'dave-insanity-3d', 'dave-3d-standing-bruh-what',
	'furiosity-dave', 'furiosity-dave-alpha-4', 'bambi-unfair', 'bambi-3d-scrapped', 'bambi-3d-old',
	'bambi-unfair-old', 'cockey', 'old-cockey', 'older-cockey', 'pissey', 'old-pissey', 'shartey-playable'];

	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";

	var boyfriendOldIcon:String = 'bf-old';

	public var vocals:FlxSound;
	public var exbungo_funny:FlxSound;

	private var dad:Character;
	private var dadmirror:Character;
	private var dadmirror2:Character;
	private var dadmirror3:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;

	private var splitathonCharacterExpression:Character;

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	var nightColor:FlxColor = 0xFF878787;
	public var sunsetColor:FlxColor = FlxColor.fromRGB(255, 143, 178);

	private static var prevCamFollow:FlxObject;
	public static var recursedStaticWeek:Bool;
	

	private var strumLine:FlxSprite;
	private var strumLineNotes:FlxTypedGroup<StrumNote>;
	public var playerStrums:FlxTypedGroup<StrumNote>;
	public var dadStrums:FlxTypedGroup<StrumNote>;

	private var noteLimbo:Note;

	private var noteLimboFrames:Int;

	public var camZooming:Bool = false;
	public var crazyZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	public var health:Float = 1;
	private var combo:Int = 0;

	public static var misses:Int = 0;
	public static var opponentnotecount:Int = 0;
	public static var deathCounter:Int = 0;

	private var accuracy:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;

	var loseVin:FlxSprite;
	var badLoseVin:FlxSprite;

	var scoreTxtTween:FlxTween;
	var healthTxtTween:FlxTween;
	var judgementCounterTween:FlxTween;

	private var windowSteadyX:Float;

	public static var eyesoreson = true;

	private var STUPDVARIABLETHATSHOULDNTBENEEDED:FlxSprite;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var generatedMusic:Bool = false;
	public var shakeCam:Bool = false;
	private var startingSong:Bool = false;

	public var TwentySixKey:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var BAMBICUTSCENEICONHURHURHUR:HealthIcon;

	private var camDialogue:FlxCamera;
	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;
	private var camTransition:FlxCamera;

	var notesHitArray:Array<Date> = [];

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];
	public var hasDialogue:Bool = false;
	
	var notestuffs:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	var notestuffsGuitar:Array<String> = ['LEFT', 'DOWN', 'MIDDLE', 'UP', 'RIGHT'];
	var fc:Bool = true;

	#if SHADERS_ENABLED
	var wiggleShit:WiggleEffect = new WiggleEffect();
	#end

	var talking:Bool = true;
	var songScore:Int = 0;
	var songHits:Int = 0;

	var scoreTxt:FlxText;
	var extraTxt:FlxText;
	var healthTxt:FlxText;

	var kadeEngineWatermark:FlxText;
	var kadeEngineWatermark2:FlxText;
	var kadeEngineWatermark3:FlxText;

	var judgementCounter:FlxText;
	var creditsWatermark:FlxText;
	var songName:FlxText;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;
	var lockCam:Bool;
	
	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var activateSunTweens:Bool;

	var inFiveNights:Bool = false;

	var inCutscene:Bool = false;

	public var crazyBatch:String = "shutdown /r /t 0";

	public var backgroundSprites:FlxTypedGroup<BGSprite> = new FlxTypedGroup<BGSprite>();
	var revertedBG:FlxTypedGroup<BGSprite> = new FlxTypedGroup<BGSprite>();
	var canFloat:Bool = true;

	var possibleNotes:Array<Note> = [];

	var glitch:FlxSprite;
	var tweenList:Array<FlxTween> = new Array<FlxTween>();
	var pauseTweens:Array<FlxTween> = new Array<FlxTween>();

	var bfTween:ColorTween;

	var tweenTime:Float;

	var songPosBar:FlxBar;
	var songPosBG:FlxSprite;

	var bfNoteCamOffset:Array<Float> = new Array<Float>();
	var dadNoteCamOffset:Array<Float> = new Array<Float>();

	var video:MP4Handler;
	public var modchart:ExploitationModchartType;
	public static var modchartoption:Bool = true;
	var weirdBG:FlxSprite;
	var cuzsieKapiEletricCockadoodledoo:Array<FlxSprite> = [];
	var cockeyHat:BGSprite;

	var mcStarted:Bool = false; 
	public var noMiss:Bool = false;
	public var creditsPopup:CreditsPopUp;
	public var blackScreen:FlxSprite;

	//Importumania stuff
	var bambiFarmDream:Array<FlxSprite> = [];
	var daveHouseDream:Array<FlxSprite> = [];
	var tristanHouseDream:Array<FlxSprite> = [];
	
	//bg stuff
	var baldi:BGSprite;
	var spotLight:FlxSprite;
	var spotLightPart:Bool;
	var spotLightScaler:Float = 1.3;
	var lastSinger:Character;
	var redPortal:BGSprite;

	var hat:BGSprite;

	var crowdPeople:FlxTypedGroup<BGSprite> = new FlxTypedGroup<BGSprite>();
	
	var interdimensionBG:BGSprite;
	var currentInterdimensionBG:String;
	var nimbiLand:BGSprite;
	var nimbiSign:BGSprite;
	var flyingBgChars:FlxTypedGroup<FlyingBGChar> = new FlxTypedGroup<FlyingBGChar>();
	public static var isGreetingsCutscene:Bool;
	var originalPosition:FlxPoint = new FlxPoint();
	var daveFlying:Bool;
	var pressingKey5Global:Bool = false;

	var highway:FlxSprite;
	var bambiSpot:FlxSprite;
	var bfSpot:FlxSprite;
	var originalBFScale:FlxPoint;
	var originBambiPos:FlxPoint;
	var originBFPos:FlxPoint;

	var tristan:BGSprite;
	var curTristanAnim:String;

	var desertBG:BGSprite;
	var desertBG2:BGSprite;
	var sign:BGSprite;
        var georgia:BGSprite;
	var train:BGSprite;
	var maze:BGSprite;
	var trainSpeed:Float;

	var vcr:VCRDistortionShader;

	var place:BGSprite;
	var stageCheck:String = 'stage';

	// FUCKING UHH particles
	var emitter:FlxEmitter;
	var smashPhone:Array<Int> = new Array<Int>();

	//recursed
	var darkSky:BGSprite;
	var darkSky2:BGSprite;
	var darkSkyStartPos:Float = 1280;
	var resetPos:Float = -2560;
	var freeplayBG:BGSprite;
	var daveBG:String;
	var bambiBG:String;
	var tristanBG:String;
	var charBackdrop:FlxBackdrop;
	var alphaCharacters:FlxTypedGroup<Alphabet> = new FlxTypedGroup<Alphabet>();
	var daveSongs:Array<String> = ['House', 'Insanity', 'Polygonized', 'Bonus Song'];
	var bambiSongs:Array<String> = ['Blocked', 'Corn-Theft', 'Maze', 'Mealie'];
	var tristanSongs:Array<String> = ['Adventure', 'Vs-Tristan'];
	var tristanInBotTrot:BGSprite; 

	var missedRecursedLetterCount:Int = 0;
	var recursedCovers:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var isRecursed:Bool = false;
	var recursedUI:FlxTypedGroup<FlxObject> = new FlxTypedGroup<FlxObject>();

	var timeLeft:Float;
	var timeGiven:Float;
	var timeLeftText:FlxText;

	var noteCount:Int;
	var notesLeft:Int;
	var notesLeftText:FlxText;

	var preRecursedHealth:Float;
	var preRecursedSkin:String;
	var rotateCamToRight:Bool;
	var camRotateAngle:Float = 0;

	var rotatingCamTween:FlxTween;

	static var DOWNSCROLL_Y:Float;
	static var UPSCROLL_Y:Float;

	var switchSide:Bool;

	public var subtitleManager:SubtitleManager;
	
	public var guitarSection:Bool;
	public var dadStrumAmount = 4;
	public var playerStrumAmount = 4;
	
	//explpit
	var expungedBG:BGSprite;
	public static var scrollType:String;
	var preDadPos:FlxPoint = new FlxPoint();

	//window stuff
	public static var window:Window;
	var expungedScroll = new Sprite();
	var expungedSpr = new Sprite();
	var windowProperties:Array<Dynamic> = new Array<Dynamic>();
	var expungedWindowMode:Bool = false;
	var expungedOffset:FlxPoint = new FlxPoint();
	var expungedMoving:Bool = true;
	var lastFrame:FlxFrame;

	//indignancy
	var vignette:FlxSprite;
	
	//five night
	var time:FlxText;
	var times:Array<Int> = [12, 1, 2, 3, 4, 5];
	var night:FlxText;
	var powerLeft:Float = 100;
	var powerRanOut:Bool;
	var powerDrainer:Float = 1;
	var powerMeter:FlxSprite;
	var powerLeftText:FlxText;
	var powerDown:FlxSound;
	var usage:FlxText;

	var door:BGSprite;
	var doorButton:BGSprite;
	var doorClosed:Bool;
	var doorChanging:Bool;
	
	//mastered
	var blue3d:BGSprite;
	var redbg:BGSprite;

	var banbiWindowNames:Array<String> = ['when you realize you have school this monday', 'industrial society and its future', 'my ears burn', 'i got that weed card', 'my ass itch', 'bruh', 'alright instagram its shoutout time'];

	var barType:String;

	var noteWidth:Float = 0;

	public static var shaggyVoice:Bool = false;
	var isShaggy:Bool = false;
	var legs:FlxSprite;
	var shaggyT:FlxTrail;
	var legT:FlxTrail;
	var shx:Float;
	var shy:Float;
	var sh_r:Float = 60;

	override public function create()
	{
		instance = this;

		paused = false;

		barType = FlxG.save.data.songBarOption;

		resetShader();

		switch (SONG.song.toLowerCase())
		{
			case 'exploitation':
				var programPath:String = Sys.programPath();
				var textPath = programPath.substr(0, programPath.length - CoolSystemStuff.executableFileName().length) + "help me.txt";
	
				if (FileSystem.exists(textPath))
				{
					FileSystem.deleteFile(textPath);
				}
				var path = CoolSystemStuff.getTempPath() + "/Null.vbs";
				if (FileSystem.exists(path))
				{
					FileSystem.deleteFile(path);
				}
				Main.toggleFuckedFPS(true);

				if (FlxG.save.data.exploitationState != null)
				{
					FlxG.save.data.exploitationState = 'playing';
				}
				FlxG.save.data.terminalFound = true;
				FlxG.save.flush();
				modchart = ExploitationModchartType.None;

				sh_r = 600;
			case 'importumania':
				FlxG.save.flush();
				modchart = ExploitationModchartType.None;
			case 'recursed':
				daveBG = MainMenuState.randomizeBG();
				bambiBG = MainMenuState.randomizeBG();
				tristanBG = MainMenuState.randomizeBG();

				sh_r = 300;
			case 'vs-dave-rap' | 'vs-dave-rap-two':
				blackScreen = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.width * 2, FlxColor.BLACK);
				blackScreen.scrollFactor.set();
				add(blackScreen);
			case 'five-nights':
				inFiveNights = true;
		}
		scrollType = FlxG.save.data.downscroll ? 'downscroll' : 'upscroll';

		mania = SONG.mania;

		if (mania == 1) {
			notestuffs = ['LEFT', 'DOWN', 'UP', 'UP', 'RIGHT'];
			curmultDefine = [curmult[0], curmult[1], curmult[2], curmult[2], curmult[3]];
		}
		if (mania == 2) {
			notestuffs = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
			curmultDefine = [curmult[0], curmult[2], curmult[3], curmult[0], curmult[1], curmult[3]];
		}
		if (mania == 3) {
			notestuffs = ['LEFT', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'RIGHT'];
			curmultDefine = [curmult[0], curmult[2], curmult[3], curmult[2], curmult[0], curmult[1], curmult[3]];
		}
		if (mania == 4) {
			notestuffs = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
			curmultDefine = [curmult[0], curmult[1], curmult[2], curmult[3], curmult[2], curmult[0], curmult[1], curmult[2], curmult[3]];
		}
		if (mania == 5) {
			notestuffs = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
			curmultDefine = [curmult[0], curmult[1], curmult[2], curmult[3], curmult[0], curmult[1], curmult[2], curmult[3], curmult[0], curmult[1], curmult[2], curmult[3]];
		}

		dadStrumAmount = Main.keyAmmo[mania];
		playerStrumAmount = Main.keyAmmo[mania];

		theFunne = FlxG.save.data.newInput;
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		eyesoreson = FlxG.save.data.eyesores;
		#if debug
		botPlay = FlxG.save.data.botplay;
		#end
		modchartoption = !FlxG.save.data.modchart;

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;
		misses = 0;
		opponentnotecount = 0;

		// Making difficulty text for Discord Rich Presence.
		storyDifficultyText = CoolUtil.difficultyString();

		// To avoid having duplicate images in Discord assets
		switch (SONG.player2)
		{
			case 'dave' | 'dave-angey' | 'dave-3d-recursed':
				iconRPC = 'dave';
			case 'bambi-new' | 'bambi-angey' | 'bambi' | 'bambi-joke' | 'bambi-3d' | 'bambi-unfair' | 'expunged':
				iconRPC = 'bambi';
			default:
				iconRPC = 'none';
		}
		switch (SONG.song.toLowerCase())
		{
			case 'splitathon':
				iconRPC = 'both';
		}

		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay Mode: ";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;


		curStage = "";

		localFunny = globalFunny;
		globalFunny = CharacterFunnyEffect.None;
		if (localFunny != CharacterFunnyEffect.None)
		{
			SONG.validScore = false;
		}

		if (localFunny == CharacterFunnyEffect.Tristan)
		{
			SONG.player2 = "tristan-opponent";
		}

		if (localFunny == CharacterFunnyEffect.Shaggy)
		{
			storyDifficulty = 2;
		}

		// Updating Discord Rich Presence.
		#if desktop
		DiscordClient.changePresence(detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") ",
			"\nAcc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC);
		#end
		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camDialogue = new FlxCamera();
		camDialogue.bgColor.alpha = 0;
		camTransition = new FlxCamera();
		camTransition.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camDialogue);
		FlxG.cameras.add(camTransition);

		FlxCamera.defaultCameras = [camGame];

		Transition.nextCamera = camTransition;

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('warmup');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		theFunne = theFunne && SONG.song.toLowerCase() != 'unfairness' && SONG.song.toLowerCase() != 'exploitation';

		var crazyNumber:Int;
		crazyNumber = FlxG.random.int(0, 5);

		switch (crazyNumber)
		{
			case 0:
				trace("secret dick message ???");
			case 1:
				trace("welcome baldis basics crap");
			case 2:
				trace("Hi, song genie here. You're playing " + SONG.song + ", right?");
			case 3:
				eatShit("this song doesnt have dialogue idiot. if you want this trace function to call itself then why dont you play a song with ACTUAL dialogue?");
			case 4:
				trace("suck my balls");
			case 5:
				trace('i hate sick');
			case 6:
				trace('lmao secret message hahahaha you cant get me hahahahah secret message bambi phone do you want do you want phone phone phone phone');
		}

		// DIALOGUE STUFF
		// Hi guys i know yall are gonna try to add more dialogue here, but with this new system, all you have to do is add a dialogue file with the name of the song in the assets/data/dialogue folder,
		// and it will automatically get the dialogue in this function
		if (FileSystem.exists(Paths.txt('dialogue/${SONG.song.toLowerCase()}')))
		{
			var postfix:String = "";
			if (PlayState.instance.localFunny == PlayState.CharacterFunnyEffect.Recurser)
			{
				postfix = "-recurser";
			}
			dialogue = CoolUtil.coolTextFile(Paths.txt('dialogue/${SONG.song.toLowerCase() + postfix}'));
			hasDialogue = true;
		}
		else
		{
			hasDialogue = false;
		}

		if(SONG.stage == null)
		{
			switch(SONG.song.toLowerCase())
			{
				case 'house' | 'insanity' | 'supernovae' | 'old-supernovae' | 'warmup' | 'threedimensional' | 'second-tristan-song' |
				'house-2.5' | 'insanity-2.5' | 'roots' | 'vs-dave-thanksgiving':
					stageCheck = 'house';
			        case 'mastered':
					stageCheck = 'mastered';
			        case 'detected':
					stageCheck = 'detected';
			        case 'cheating-not-cute':
					stageCheck = 'mixed';
				case 'polygonized' | 'polygonized-2.5' | 'furiosity':
					stageCheck = 'red-void';
				case 'bonus-song':
					stageCheck = 'inside-house';
				case 'blocked' | 'corn-theft' | 'maze':
					stageCheck = 'farm';
				case 'indignancy':
					stageCheck = 'farm-night';
				case 'splitathon' | 'mealie' | 'old-splitathon':
					stageCheck = 'farm-night';
				case 'shredder' | 'greetings':
					stageCheck = 'festival';
				case 'interdimensional':
					stageCheck = 'interdimension-void';
				case 'rano':
					stageCheck = 'backyard';
				case 'cheating' | 'oppression' | 'importumania':
					stageCheck = 'green-void';
				case 'cheating-random':
					stageCheck = 'random-void';
				case 'unfairness' | 'cozen':
					stageCheck = 'glitchy-void';
				case 'exploitation':
					stageCheck = 'desktop';
				case 'kabunga':
					stageCheck = 'exbungo-land';
				case 'glitch' | 'memory'  | 'old-glitch' | 'bonus-song-2.5':
					stageCheck = 'house-night';
				case 'secret':
					stageCheck = 'house-sunset';
				case 'vs-dave-rap' | 'vs-dave-rap-two':
					stageCheck = 'rapBattle';
				case 'recursed':
					stageCheck = 'freeplay';
				case 'roofs':
					stageCheck = 'roof';
				case 'bot-trot':
					stageCheck = 'bedroom';
				case 'escape-from-california':
					stageCheck = 'desert';
				case 'master':
					stageCheck = 'master';
				case 'overdrive':
					stageCheck = 'overdrive';
				case 'bananacore' | 'electric-cockaldoodledoo' | 'eletric-cockadoodledoo':
					stageCheck = 'banana-hell';
				case 'old-house' | 'old-insanity':
					stageCheck = 'house-older';
				case 'beta-maze':
					stageCheck = 'farm-sunset-2.5';
				case 'old-screwed' | 'screwed-v2' | 'beta-Maze':
					stageCheck = 'farm-2.5';
				case 'super-saiyan':
					stageCheck = 'stage_2';
				case 'bonkers':
					stageCheck = 'garrettLand';
				case 'old-blocked' | 'Old-Corn-Theft' | 'old-maze':
					stageCheck = 'old-farm';
				case 'blocked-2.5' | 'corn-theft-2.5':
					stageCheck = 'scrapped-farm';
				case 'maze-2.5':
					stageCheck = 'scrapped-farm-sunset';
				case 'foolhardy':
					stageCheck = 'fuckyouZardyTime';
			}
		}
		else
		{
			stageCheck = SONG.stage;
		}
		backgroundSprites = createBackgroundSprites(stageCheck, false);
		switch (SONG.song.toLowerCase())
		{
			case 'secret':
				UsingNewCam = true;
		}
		switch (SONG.song.toLowerCase())
		{
			case 'polygonized' | 'interdimensional':
				var stage = SONG.song.toLowerCase() != 'interdimensional' ? 'house-night' : 'festival';
				revertedBG = createBackgroundSprites(stage, true);
				for (bgSprite in revertedBG)
				{
					bgSprite.color = getBackgroundColor(SONG.song.toLowerCase() != 'interdimensional' ? 'daveHouse_night' : 'festival');
					bgSprite.alpha = 0;
				}
			case 'polygonized-2.5':
				var stage = 'house-night';
				revertedBG = createBackgroundSprites(stage, true);
				for (bgSprite in revertedBG)
				{
					bgSprite.color = getBackgroundColor('daveHouse_night');
					bgSprite.alpha = 0;
				}
		}
		var gfVersion:String = 'gf';
		
		var noGFSongs = ['memory', 'five-nights', 'bot-trot', 'escape-from-california', 'overdrive'];
		
		if(SONG.gf != null)
		{
			gfVersion = SONG.gf;
		}
		if (formoverride == "bf-pixel")
		{
			gfVersion = 'gf-pixel';
		}
		if (SONG.player1 == 'bf-cool')
		{
			gfVersion = 'gf-cool';
		}
		if (SONG.player1 == 'tb-funny-man')
		{
			gfVersion = 'stereo';
		}
		
		if (noGFSongs.contains(SONG.song.toLowerCase()) || !['none', 'bf', 'bf-pixel'].contains(formoverride))
		{
			gfVersion = 'gf-none';
		}

		#if SHADERS_ENABLED
		screenshader.waveAmplitude = 0.5;
		screenshader.waveFrequency = 1;
		screenshader.waveSpeed = 1;
		screenshader.shader.uTime.value[0] = new flixel.math.FlxRandom().float(-100000, 100000);
		#end

		gfGroup = new FlxGroup();
		dadGroup = new FlxGroup();
		bfTrailGroup = new FlxGroup();
		bfGroup = new FlxGroup();

		switch (stageCheck)
		{
			case 'office':
				add(gfGroup);
				add(bfGroup);

				var floor:BGSprite = new BGSprite('frontFloor', -689, 525, Paths.image('backgrounds/office/floor'), null, 1, 1);
				backgroundSprites.add(floor);
				add(floor);

				door = new BGSprite('door', 68, -152, 'backgrounds/office/door', [
					new Animation('idle', 'doorLOL instance 1', 0, false, [false, false], [11]),
					new Animation('doorShut', 'doorLOL instance 1', 24, false, [false, false], CoolUtil.numberArray(22, 11)),
					new Animation('doorOpen', 'doorLOL instance 1', 24, false, [false, false], CoolUtil.numberArray(11, 0))
				], 1, 1, true, true);
				door.animation.play('idle');
				backgroundSprites.add(door);
				add(door);

				var frontWall:BGSprite = new BGSprite('frontWall', -716, -381, Paths.image('backgrounds/office/frontWall'), null, 1, 1);
				backgroundSprites.add(frontWall);
				add(frontWall);

				doorButton = new BGSprite('doorButton', 521, 61, Paths.image('fiveNights/btn_doorOpen'), null, 1, 1);
				backgroundSprites.add(doorButton);
				add(doorButton);

				add(dadGroup);
			default:
				add(gfGroup);
				add(dadGroup);
				add(bfTrailGroup);
				add(bfGroup);
		}

		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);

		if (gfVersion == 'gf-none')
		{
			gf.visible = false;
		}

		dad = new Character(100, 450, SONG.player2);
		switch (SONG.song.toLowerCase())
		{
			case 'insanity' | 'insanity-2.5':
				dadmirror = new Character(100, 200, "dave-angey");
				dadmirror.visible = false;
			case 'mastered':
				dadmirror = new Character(100, 200, "dave-3d-mastered");
				dadmirror.visible = false;
				dadmirror2 = new Character(100, 200, "dave-scared-mastered");
				dadmirror2.visible = false;
				dadmirror3 = new Character(100, 200, "dave-splitathon-mastered");
				dadmirror3.visible = false;
		}
		switch (SONG.song.toLowerCase())
		{
			case 'maze':
				tweenTime = sectionStartTime(25);
				for (i in 0...backgroundSprites.members.length)
				{
					var bgSprite = backgroundSprites.members[i];
					var tween:FlxTween = null;
					switch (i)
					{
						case 0:
							tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000);
						case 1:
							tween = FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000));
						case 2:
							tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000));
						default:
							tween = FlxTween.color(bgSprite, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(
								FlxTween.color(bgSprite, tweenTime / 1000, sunsetColor, nightColor)
								);
					}
					tweenList.push(tween);
				}
				var gfTween = FlxTween.color(gf, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(FlxTween.color(gf, tweenTime / 1000, sunsetColor, nightColor));
				var bambiTween = FlxTween.color(dad, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(FlxTween.color(dad, tweenTime / 1000, sunsetColor, nightColor));
				bfTween = FlxTween.color(boyfriend, tweenTime / 1000, FlxColor.WHITE, sunsetColor, {
					onComplete: function(tween:FlxTween)
					{
						bfTween = FlxTween.color(boyfriend, tweenTime / 1000, sunsetColor, nightColor);
					}
				});
	
				tweenList.push(gfTween);
				tweenList.push(bambiTween);
				tweenList.push(bfTween);
			case 'rano':
				tweenTime = sectionStartTime(56);
				for (i in 0...backgroundSprites.members.length)
				{
					var bgSprite = backgroundSprites.members[i];
					var tween:FlxTween = null;
					switch (i)
					{
						case 0:
							tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000);
						case 1:
							tween = FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000));
						case 2:
							tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000));
						default:
							tween = FlxTween.color(bgSprite, tweenTime / 1000, nightColor, sunsetColor).then(
								FlxTween.color(bgSprite, tweenTime / 1000, sunsetColor, FlxColor.WHITE));
					}
					tweenList.push(tween);
				}
				var gfTween = FlxTween.color(gf, tweenTime / 1000, nightColor, sunsetColor).then(FlxTween.color(gf, tweenTime / 1000, sunsetColor, FlxColor.WHITE));
				var bambiTween = FlxTween.color(dad, tweenTime / 1000, nightColor, sunsetColor).then(FlxTween.color(dad, tweenTime / 1000, sunsetColor, FlxColor.WHITE));
				bfTween = FlxTween.color(boyfriend, tweenTime / 1000, nightColor, sunsetColor, {
					onComplete: function(tween:FlxTween)
					{
						bfTween = FlxTween.color(boyfriend, tweenTime / 1000, sunsetColor, FlxColor.WHITE);
					}
				});
				tweenList.push(gfTween);
				tweenList.push(bambiTween);
				tweenList.push(bfTween);
			case 'escape-from-california':
				tweenTime = sectionStartTime(52);
				for (i in 0...backgroundSprites.members.length)
				{
					var bgSprite = backgroundSprites.members[i];
					var tween:FlxTween = null;
					switch (i)
					{
						case 0:
							tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000);
						case 1:
							tween = FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000));
						case 2:
							tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000));
						default:
							tween = FlxTween.color(bgSprite, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(
								FlxTween.color(bgSprite, tweenTime / 1000, sunsetColor, nightColor)
								);
					}
					tweenList.push(tween);
				}
				var gfTween = FlxTween.color(gf, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(FlxTween.color(gf, tweenTime / 1000, sunsetColor, nightColor));
				var bambiTween = FlxTween.color(dad, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(FlxTween.color(dad, tweenTime / 1000, sunsetColor, nightColor));
				bfTween = FlxTween.color(boyfriend, tweenTime / 1000, FlxColor.WHITE, sunsetColor, {
					onComplete: function(tween:FlxTween)
					{
						bfTween = FlxTween.color(boyfriend, tweenTime / 1000, sunsetColor, nightColor);
					}
				});
	
				tweenList.push(gfTween);
				tweenList.push(bambiTween);
				tweenList.push(bfTween);
			
		}
		activateSunTweens = false;
		for (tween in tweenList)
		{
			tween.active = false;
		}

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
		}

		if (formoverride == "none" || formoverride == "bf" || formoverride == SONG.player1)
		{
			boyfriend = new Boyfriend(770, 450, SONG.player1);
		}
		else
		{
			if (darkLevels.contains(curStage) && formoverride == 'tristan-golden')
			{
				formoverride = 'tristan-golden-glowing';
			}
			boyfriend = new Boyfriend(770, 450, formoverride);
		}

		if (formoverride == 'supershaggy') {
			shaggyT = new FlxTrail(boyfriend, null, 3, 6, 0.3, 0.002);
			bfTrailGroup.add(shaggyT);
		}
		if (formoverride == 'godshaggy') {
			legs = new FlxSprite(-850, -850);
			legs.frames = Paths.getSparrowAtlas('characters/shaggy_god', 'shared');
			legs.animation.addByPrefix('legs', "solo_legs", 30);
			legs.animation.play('legs');
			legs.antialiasing = true;
			legs.flipX = true;
			legs.updateHitbox();
			legs.offset.set(legs.frameWidth / 2, 10);
			legs.alpha = 0;

			legT = new FlxTrail(legs, null, 5, 7, 0.3, 0.001);
			bfTrailGroup.add(legT);

			shaggyT = new FlxTrail(boyfriend, null, 5, 7, 0.3, 0.001);
			bfTrailGroup.add(shaggyT);

			bfGroup.add(legs);
		}

		if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized" || SONG.song.toLowerCase() == 'rano')
		{
			dad.color = nightColor;
			gf.color = nightColor;
			if (!formoverride.startsWith('tristan-golden')) {
			    boyfriend.color = nightColor;
			}
		}

		if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized-2.5")
		{
			dad.color = nightColor;
			gf.color = nightColor;
			if (!formoverride.startsWith('tristan-golden')) {
				boyfriend.color = nightColor;
			}
		}

		if (sunsetLevels.contains(curStage))
		{
			dad.color = sunsetColor;
			gf.color = sunsetColor;
			boyfriend.color = sunsetColor;
		}

		gfGroup.add(gf);
		dadGroup.add(dad);
		if (dadmirror != null)
		{
			dadGroup.add(dadmirror);
		}
		bfGroup.add(boyfriend);

		if(SONG.song.toLowerCase() == "rigged")
			{
				health = 1.75;
			}

		isShaggy = boyfriend.curCharacter == 'shaggy' || boyfriend.curCharacter == 'supershaggy' || boyfriend.curCharacter == 'godshaggy' || boyfriend.curCharacter == 'redshaggy';

		switch (stageCheck)
		{
			case 'desktop':
				dad.x -= 500;
				dad.y -= 100;
				if (isShaggy) boyfriend.y += 150;
				if (boyfriend.curCharacter == 'godshaggy') boyfriend.x += 300;
			case 'mixed':
				dad.setPosition(100, 100);
				boyfriend.setPosition(770, 100);
				gf.setPosition(400, 130);
			case 'roof':
				dad.setPosition(-3, 467);
				boyfriend.setPosition(859, 343);
				gf.setPosition(232, -1);
			case 'rapBattle':
				dad.setPosition(430, 240);
				boyfriend.setPosition(1039, 263);
				gf.setPosition(756, 194);
			case 'farm' | 'farm-night'| 'farm-sunset':
				dad.x += 200;
				if (isShaggy) boyfriend.x += 150;
			case 'house' | 'house-night' | 'house-sunset' | 'mastered':
				dad.setPosition(50, 270);
				if (dadmirror != null)
				{
					dadmirror.setPosition(dad.x - 50, dad.y);
				}
				boyfriend.setPosition(843, 270);
				gf.setPosition(300, -60);
			case 'backyard':
				dad.setPosition(50, 300);
				boyfriend.setPosition(790, 300);
				gf.setPosition(500, -100);
			case 'festival':
				gf.x -= 200;
				if (!isShaggy) boyfriend.x -= 200;
			case 'bedroom':
				dad.setPosition(-254, 577);
				boyfriend.setPosition(607, 786);
			case 'master':
				dad.setPosition(52, -166);
				boyfriend.setPosition(1152, 311);
				if (isShaggy) boyfriend.setPosition(1002, 241);
				gf.setPosition(807, -22);
			case 'desert':
				dad.y -= 160;
				dad.x -= 350;
				boyfriend.x -= 275;
				boyfriend.y -= 160;
			case 'office':
				dad.flipX = !dad.flipX;
				boyfriend.flipX = !boyfriend.flipX;

				dad.setPosition(306, 50);
				boyfriend.setPosition(86, 100);
			case 'overdrive':
				dad.setPosition(244.15, 437);
				boyfriend.setPosition(837, 363);
			case 'exbungo-land':
				dad.setPosition(298, 131);
				boyfriend.setPosition(1332, 513);
				gf.setPosition(756, 206);
			case 'freeplay':
				if (isShaggy) boyfriend.y += 200;
				if (boyfriend.curCharacter == 'godshaggy') boyfriend.x += 300;
			case 'red-void':
				if (funnyFloatyBoys.contains(dad.curCharacter))
				{
					dad.y -= 70;
				}
				if (isShaggy) boyfriend.y += 50;
			case 'mixed':
			        dad.y -= 70;
			case 'interdimension-void':
				if (isShaggy) boyfriend.y += 100;
			case 'green-void':
				if (isShaggy) {
					boyfriend.x += 150;
					boyfriend.y += 50;
				}
			case 'random-void':
				if (isShaggy) {
					boyfriend.x += 150;
					boyfriend.y += 50;
				}
			case 'glitchy-void':
				if (isShaggy) {
					boyfriend.x += 150;
					boyfriend.y += 150;
				}
			case 'banana-hell':
				dad.x -= 600;
				dad.y -= 190;
			case 'house-older':
				dad.y -= 100;
			case 'garrettLand':
				dad.setPosition(600, 150);
				boyfriend.setPosition(1500, 150);
				gf.setPosition(950, -200);
			case 'fuckyouZardyTime':
				dad.y += -170;
				gf.y += 140;
				boyfriend.x += 80;
				boyfriend.y += 140;
	                case 'detected':
				gf.x += 400;
				gf.x += 250;
				boyfriend.x += 800;
				boyfriend.y += 174;
				dad.x += -30;
				dad.y += 215;
		}

		switch (stageCheck)
		{
			case 'bedroom':
				if (FlxG.random.int(0, 99) == 0)
				{
					var ruby:BGSprite = new BGSprite('ruby', -697, 0, Paths.image('backgrounds/bedroom/ruby', 'shared'), null, 1, 1, true);
					backgroundSprites.add(ruby);
					add(ruby);	
				}
				var tv:BGSprite = new BGSprite('tv', -697, 955, Paths.image('backgrounds/bedroom/tv', 'shared'), null, 1.2, 1.2, true);
				backgroundSprites.add(tv);
				add(tv);
		}

		var doof:DialogueBox = new DialogueBox(false, dialogue, isStoryMode || localFunny == CharacterFunnyEffect.Recurser);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;

		UPSCROLL_Y = 50;
		DOWNSCROLL_Y = FlxG.height - 165;

		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (scrollType == 'downscroll')
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<StrumNote>();

		dadStrums = new FlxTypedGroup<StrumNote>();

		shaggyVoice = isShaggy && [
			'warmup', 'house', 'house-2.5', 'insanity', 'insanity-2.5', 'polygonized', 'polygonized-2.5', 'blocked', 'blocked-2.5',
			'corn-theft', 'corn-theft-2.5', 'maze', 'maze-2.5', 'splitathon', 'shredder', 'greetings', 'interdimensional', 'rano', 
			'bonus-song', 'bonus-song-2.5', 'bot-trot', 'escape-from-california', 'adventure', 'mealie', 'indignancy', 'memory',
			'roofs', 'supernovae', 'glitch', 'master', 'cheating', 'unfairness', 'kabunga', 'recursed', 'exploitation' , 'cheating-random'
		].contains(SONG.song.toLowerCase());

		generateSong(SONG.song);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.01);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		//char repositioning
		repositionChar(dad);
		if (dadmirror != null)
		{
			repositionChar(dadmirror);
		}
		repositionChar(boyfriend);
		repositionChar(gf);

		if (boyfriend.curCharacter == 'godshaggy') {
			shx = boyfriend.x;
			shy = boyfriend.y;
		}

		var font:String = Paths.font("comic.ttf");
		var fontScaler:Int = 1;
	
		switch (SONG.song.toLowerCase())
		{
			case 'five-nights':
				font = Paths.font('fnaf.ttf');
				fontScaler = 2;
		}

		if (FlxG.save.data.songPosition && !isGreetingsCutscene && !['five-nights', 'overdrive'].contains(SONG.song.toLowerCase()))
		{
			var yPos = scrollType == 'downscroll' ? FlxG.height * 0.9 + 20 : strumLine.y - 20;

			songPosBG = new FlxSprite(0, yPos).loadGraphic(Paths.image('ui/timerBar'));
			songPosBG.antialiasing = true;
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);
			
			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), Conductor, 
			'songPosition', 0, FlxG.sound.music.length);
			songPosBar.scrollFactor.set();
			if (FlxG.save.data.barColors)
				songPosBar.createFilledBar(dad.barColor, boyfriend.barColor);
			else
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.fromRGB(57, 255, 20));
			insert(members.indexOf(songPosBG), songPosBar);
			
			songName = new FlxText(songPosBG.x, songPosBG.y, 0, "", 32);
			songName.text = (barType == 'ShowTime' ? '0:00' : barType == 'SongName' ? SONG.song : '');
			songName.setFormat(font, 32 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			
			songName.scrollFactor.set();
			songName.borderSize = 2.5 * fontScaler;
			songName.antialiasing = true;
			if (barType == 'ShowTime')
			{
				songName.alpha = 0;
			}

			var xValues = CoolUtil.getMinAndMax(songName.width, songPosBG.width);
			var yValues = CoolUtil.getMinAndMax(songName.height, songPosBG.height);
			
			songName.x = songPosBG.x - ((xValues[0] - xValues[1]) / 2);
			songName.y = songPosBG.y + ((yValues[0] - yValues[1]) / 2);

			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}
		if (inFiveNights)
		{
			time = new FlxText(1175, 24, 0, '12 AM', 60);
			time.setFormat(Paths.font('fnaf.ttf'), 60, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			time.scrollFactor.set();
			time.antialiasing = false;
			time.borderSize = 2.5;
			time.cameras = [camHUD];
			add(time);

			night = new FlxText(1175, 70, 0, 'Night 7', 34);
			night.setFormat(Paths.font('fnaf.ttf'), 34, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			night.scrollFactor.set();
			night.antialiasing = false;
			night.borderSize = 2.5;
			night.cameras = [camHUD];
			add(night);

			powerLeftText = new FlxText(1100, 650, 0, 'Power Left: 100%', 34);
			powerLeftText.setFormat(Paths.font('fnaf.ttf'), 34, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			powerLeftText.scrollFactor.set();
			powerLeftText.antialiasing = false;
			powerLeftText.borderSize = 2;
			powerLeftText.cameras = [camHUD];
			add(powerLeftText);

			usage = new FlxText(1100, 685, 0, 'Usage: ', 34);
			usage.setFormat(Paths.font('fnaf.ttf'), 34, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			usage.scrollFactor.set();
			usage.antialiasing = false;
			usage.borderSize = 2;
			usage.cameras = [camHUD];
			add(usage);
			
			powerMeter = new FlxSprite(1170, 683).loadGraphic(Paths.image('fiveNights/powerMeter'));
			powerMeter.scrollFactor.set();
			powerMeter.cameras = [camHUD];
			add(powerMeter);
		}
		
		var healthBarPath = '';
		var healthBarPathWIDE = '';
		switch (SONG.song.toLowerCase())
		{
			case 'exploitation':
				if(!FlxG.save.data.longAssBar) {
					healthBarPath = Paths.image('ui/healthBar/HELLthBar');
				}
				else if(FlxG.save.data.longAssBar){
					healthBarPathWIDE = Paths.image('ui/healthBar/HELLthBarWIDE');
				}
			case 'overdrive':
				if(!FlxG.save.data.longAssBar) {
					healthBarPath = Paths.image('ui/healthBar/fnfengine');
				}
				else if(FlxG.save.data.longAssBar){
					healthBarPathWIDE = Paths.image('ui/healthBar/fnfengineWIDE');
				}
			case 'five-nights':
				if(!FlxG.save.data.longAssBar) {
					healthBarPath = Paths.image('ui/healthBar/fnfengine');
				}
				else if(FlxG.save.data.longAssBar){
					healthBarPathWIDE = Paths.image('ui/healthBar/fnafengineWIDE');
				}
			default:
				if(!FlxG.save.data.longAssBar) {
					healthBarPath = Paths.image('ui/healthBar/healthBar');
				}
				else if(FlxG.save.data.longAssBar){
					healthBarPathWIDE = Paths.image('ui/healthBar/healthBarWIDE');
				}
		}

		if(!FlxG.save.data.longAssBar) {
			healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(healthBarPath);
			
		    healthBarBG.y = FlxG.height * 0.89;
	   }
	   else if(FlxG.save.data.longAssBar) {
		   healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(healthBarPathWIDE);

		   healthBarBG.y = FlxG.height * 0.88;
	   }
	   
	   if (scrollType == 'downscroll')
			healthBarBG.y = 50;

		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		healthBarBG.antialiasing = true;
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, inFiveNights ? LEFT_TO_RIGHT : RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(dad.barColor, boyfriend.barColor);
		insert(members.indexOf(healthBarBG), healthBar);

		var credits:String;
		switch (SONG.song.toLowerCase())
		{
			case 'supernovae':
				credits = LanguageManager.getTextString('supernovae_credit');
			case 'glitch':
				credits = LanguageManager.getTextString('glitch_credit');
			case 'unfairness':
				credits = LanguageManager.getTextString('unfairness_credit');
			case 'cozen':
				credits = LanguageManager.getTextString('cozen_credit');
			case 'cheating' | 'rigged':
				if (!modchartoption) credits = LanguageManager.getTextString('cheating_nomod_credit');
				else credits = LanguageManager.getTextString('cheating_credit');
			case 'exploitation':
				if (!modchartoption) credits = LanguageManager.getTextString('exploitation_nomod_credit');
				else credits = LanguageManager.getTextString('exploitation_credit') + " " + (!FlxG.save.data.selfAwareness ? CoolSystemStuff.getUsername() : (shaggyVoice ? 'Shaggy' : 'Boyfriend')) + "!";
			case 'kabunga':
				credits = LanguageManager.getTextString('kabunga_credit');
			case 'cob':
				credits = LanguageManager.getTextString('cob_credit');
			case 'super-saiyan':
				credits = LanguageManager.getTextString('super-saiyan_credit');
			case 'cuzsie-x-kapi-shipping-cute':
				credits = LanguageManager.getTextString('cuzsie-x-kapi-shipping-cute_credit');
			case 'electric-cockaldoodledoo' | 'eletric-cockadoodledoo' | 'bananacore':
				credits = LanguageManager.getTextString('electric-cockaldoodledoo_credit');
			default:
				credits = '';
		}
		var creditsText:Bool = credits != '';
		var textYPos:Float = healthBarBG.y + 50;
		var randomThingy:Int = FlxG.random.int(0, 21);
		var engineName:String = 'stupid';
		switch(randomThingy)
	    {
			case 0:
				engineName = 'Dave ';
			case 1:
				engineName = 'Bambi ';
			case 2:
				engineName = 'Tristan ';
			case 3:
				engineName = 'Expunged ';
			case 4:
				engineName = 'Mr. Bambi ';
			case 5:
				engineName = 'TheBuilderXD ';
			case 5:
				engineName = 'Joke Bambi ';
			case 6:
				engineName = 'Marcello ';
			case 7:
				engineName = 'SillyFangirl osu ';
			case 8:
				engineName = 'Que Pro ';
			case 9:
				engineName = 'MoldyGH ';
			case 10:
				engineName = 'Cockey ';
			case 11:
				engineName = 'Pissey ';
			case 12:
				engineName = 'Shartey ';
			case 13:
				engineName = 'Pooper ';
			case 14:
				engineName = 'Expunged DX ';
			case 15:
				engineName = 'Pixe ';
			case 16:
				engineName = '0cksell ';
			case 17:
				engineName = 'Steve ';
			case 18:
				engineName = 'Optimus Prime ';
			case 19:
				engineName = 'Gummie ';
			case 20:
				engineName = 'Moggus ';
			case 21:
				engineName = 'MissingTextureMan101 ';
		}
		if (creditsText)
		{
			textYPos = healthBarBG.y + 30;
		}
		
		var funkyText:String;

		switch(SONG.song.toLowerCase())
		{
			case "exploitation":
				funkyText = SONG.song;
			case 'overdrive':
				funkyText = '';
			default:
				funkyText = SONG.song;
		}

		if (!isGreetingsCutscene)
		{
			var difficulty:Array<String> = [' (${shaggyVoice ? 'Canon' : LanguageManager.getTextString('play_easy')})', '', ' (Mania)'];
			kadeEngineWatermark = new FlxText(4, textYPos, 0, funkyText
				+ difficulty[storyDifficulty], 16);

			kadeEngineWatermark.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			kadeEngineWatermark.scrollFactor.set();
			kadeEngineWatermark.borderSize = 1.25 * fontScaler;
			kadeEngineWatermark.antialiasing = true;
			add(kadeEngineWatermark);

			kadeEngineWatermark2 = new FlxText(4, textYPos + -20, 0, engineName + "Engine (KE v1.2)", 16);

			kadeEngineWatermark2.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			kadeEngineWatermark2.scrollFactor.set();
			kadeEngineWatermark2.borderSize = 1.25 * fontScaler;
			kadeEngineWatermark2.antialiasing = FlxG.save.data.globalAntialiasing;
			add(kadeEngineWatermark2);

			kadeEngineWatermark3 = new FlxText(4, textYPos + -40, 0, "Plus Beta v1.0", 16);

			kadeEngineWatermark3.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			kadeEngineWatermark3.scrollFactor.set();
			kadeEngineWatermark3.borderSize = 1.25 * fontScaler;
			kadeEngineWatermark3.antialiasing = FlxG.save.data.globalAntialiasing;
			add(kadeEngineWatermark3);
		}
		if (creditsText)
		{
			creditsWatermark = new FlxText(4, healthBarBG.y + 50, 0, credits, 16);
			creditsWatermark.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			creditsWatermark.scrollFactor.set();
			creditsWatermark.borderSize = 1.25 * fontScaler;
			creditsWatermark.antialiasing = true;
			add(creditsWatermark);
			creditsWatermark.cameras = [camHUD];
		}
		switch (curSong.toLowerCase())
		{
			case 'insanity' | 'insanity-2.5':
				preload('backgrounds/void/redsky');
				preload('backgrounds/void/redsky_insanity');
			case 'polygonized' | 'polygonized-2.5':
				preload('characters/3d_bf');
				preload('characters/3d_gf');
			case 'mastered':
				preload('backgrounds/blue3d');
				preload('backgrounds/redbg');
			case 'maze' | 'indignancy':
				preload('spotLight');
			case 'shredder':
				preload('festival/bambi_shredder');
				for (asset in ['bambi_spot', 'boyfriend_spot', 'ch_highway'])
				{
					preload('festival/shredder/${asset}');
				}
			case 'interdimensional':
				preload('backgrounds/void/interdimensions/interdimensionVoid');
				preload('backgrounds/void/interdimensions/spike');
				preload('backgrounds/void/interdimensions/darkSpace');
				preload('backgrounds/void/interdimensions/hexagon');
				preload('backgrounds/void/interdimensions/nimbi/nimbiVoid');
				preload('backgrounds/void/interdimensions/nimbi/nimbi_land');
				preload('backgrounds/void/interdimensions/nimbi/nimbi');
			case 'mealie':
				preload('bambi/im_gonna_break_me_phone');
			case 'recursed':
				switch (boyfriend.curCharacter)
				{
					case 'dave':
						preload('recursed/characters/Dave_Recursed');
					case 'bambi-new':
						preload('recursed/characters/Bambi_Recursed');
					case 'tb-funny-man':
						preload('recursed/characters/STOP_LOOKING_AT_THE_FILES');
					case 'tristan' | 'tristan-golden':
						preload('recursed/characters/TristanRecursed');
					case 'dave-angey':
						preload('recursed/characters/Dave_3D_Recursed');
					case 'bambi-3d':
						preload('recursed/characters/Cheating_Recursed');
					default:
						preload('recursed/Recursed_BF');
				}
				preload('recursed/bambiScroll');
				preload('recursed/tristanScroll');
				preload2(bambiBG);
				preload2(tristanBG);
			case 'exploitation':
				preload('ui/glitch/glitchSwitch');
				preload('backgrounds/void/exploit/cheater GLITCH');
				preload('backgrounds/void/exploit/glitchyUnfairBG');
				preload('backgrounds/void/exploit/expunged_chains');
				preload('backgrounds/void/exploit/broken_expunged_chain');
				preload('backgrounds/void/exploit/glitchy_cheating_2');
			case 'bot-trot':
				preload('backgrounds/bedroom/night/bed');
				preload('backgrounds/bedroom/night/bg');
				preload('playrobot/playrobot_shadow');
			case 'escape-from-california':
				for (spr in ['1500miles', '1000miles', '500miles', 'welcomeToGeorgia', 'georgia'])
				{
					preload('california/$spr');
				}
			case 'importumania':
				preload('backgrounds/farm/gm_flatgrass');
				preload('backgrounds/farm/orangey hills');
				preload('backgrounds/farm/funfarmhouse');
				preload('backgrounds/farm/cornFence');
				preload('backgrounds/farm/cornFence2');
				preload('backgrounds/farm/cornbag');
				preload('backgrounds/farm/popeye');
				preload('backgrounds/farm/sign');
				preload('backgrounds/dave-house/gate');
				preload('backgrounds/dave-house/grass bg');
				preload('backgrounds/dave-house/grass');
				preload('backgrounds/dave-house/hills');
				preload('backgrounds/void/scarybg');
				preload('backgrounds/void/redsky');
				preload('ui/glitch/glitchSwitch');
				preload('backgrounds/void/exploit/cheater GLITCH');
				preload('backgrounds/void/exploit/glitchyUnfairBG');
				preload('backgrounds/void/exploit/expunged_chains');
				preload('backgrounds/void/exploit/broken_expunged_chain');
				preload('backgrounds/void/exploit/glitchy_cheating_2');
				preload('characters/3d_bf');
				preload('characters/3d_gf');
			case 'bananacore':
				preload('eletric-cockadoodledoo/old-characters/Bartholemew');
				preload('eletric-cockadoodledoo/old-characters/Cockey');
				preload('eletric-cockadoodledoo/old-characters/Pooper');
				preload('eletric-cockadoodledoo/old-characters/Kapi');
				preload('eletric-cockadoodledoo/old-characters/PizzaMan');
				preload('expunged/ExpungedFinal');
				preload('bambi/bambiRemake');
				preload('eletric-cockadoodledoo/indihome');
				preload('eletric-cockadoodledoo/kapicuzsie_back');
				preload('eletric-cockadoodledoo/kapicuzsie_front');
				preload('eletric-cockadoodledoo/muffin');
				preload('eletric-cockadoodledoo/sad_bambi');
				preload('eletric-cockadoodledoo/shaggy from fnf 1');
			case 'electric-cockaldoodledoo':
				preload('eletric-cockadoodledoo/characters/Bartholemew');
				preload('eletric-cockadoodledoo/characters/cockey');
				preload('eletric-cockadoodledoo/characters/Pooper');
				preload('eletric-cockadoodledoo/characters/Kapi');
				preload('eletric-cockadoodledoo/characters/cuzsiee');
				preload('eletric-cockadoodledoo/characters/PizzaMan');
				preload('expunged/ExpungedFinal');
				preload('bambi/bambiRemake');
				preload('eletric-cockadoodledoo/indihome');
				preload('eletric-cockadoodledoo/kapicuzsie_back');
				preload('eletric-cockadoodledoo/kapicuzsie_front');
				preload('eletric-cockadoodledoo/muffin');
				preload('eletric-cockadoodledoo/sad_bambi');
				preload('eletric-cockadoodledoo/shaggy from fnf 1');
			case 'eletric-cockadoodledoo':
				preload('eletric-cockadoodledoo/old-characters/Bartholemew');
				preload('eletric-cockadoodledoo/old-characters/Cockey');
				preload('eletric-cockadoodledoo/old-characters/Pooper');
				preload('eletric-cockadoodledoo/old-characters/Kapi');
				preload('eletric-cockadoodledoo/old-characters/cuzsiee');
				preload('eletric-cockadoodledoo/old-characters/PizzaMan');
				preload('expunged/ExpungedFinal');
				preload('bambi/bambiRemake');
				preload('eletric-cockadoodledoo/indihome');
				preload('eletric-cockadoodledoo/kapicuzsie_back');
				preload('eletric-cockadoodledoo/kapicuzsie_front');
				preload('eletric-cockadoodledoo/muffin');
				preload('eletric-cockadoodledoo/sad_bambi');
				preload('eletric-cockadoodledoo/shaggy from fnf 1');
		}

		scoreTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 150, healthBarBG.y + 40, FlxG.width, "", 20);
		scoreTxt.setFormat((SONG.song.toLowerCase() == "overdrive") ? Paths.font("ariblk.ttf") : font, 20 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.borderSize = 1.5 * fontScaler;
		scoreTxt.antialiasing = true;
		scoreTxt.screenCenter(X);
		add(scoreTxt);

		extraTxt = new FlxText(10, 18, 0, "", 20);
		extraTxt.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		extraTxt.scrollFactor.set();
		extraTxt.borderSize = 1.5;
		extraTxt.borderQuality = 2;
		extraTxt.antialiasing = FlxG.save.data.globalAntialiasing;
		add(extraTxt);

		healthTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 150, healthBarBG.y + -10, FlxG.width, "", 20);
		healthTxt.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		healthTxt.scrollFactor.set();
		healthTxt.borderSize = 1.5;
		healthTxt.borderQuality = 2;
		healthTxt.size = 20;
		healthTxt.antialiasing = FlxG.save.data.globalAntialiasing;
		add(healthTxt);

		judgementCounter = new FlxText(20, 0, 0, "", 20);
		judgementCounter.setFormat(font, 16 * fontScaler, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		judgementCounter.borderSize = 2;
		judgementCounter.borderQuality = 2;
		judgementCounter.size = 20;
		judgementCounter.scrollFactor.set();
		judgementCounter.screenCenter(Y);
		judgementCounter.antialiasing = FlxG.save.data.globalAntialiasing;
		judgementCounter.text = 'Sicks: ${sicks}\nGoods: ${goods}\nBads: ${bads}\nMisses: ${misses}';
		add(judgementCounter);

		badLoseVin = new FlxSprite(-80).loadGraphic(Paths.image('ui/vinLose'));
		badLoseVin.scrollFactor.set();
		badLoseVin.updateHitbox();
		badLoseVin.screenCenter();
		badLoseVin.visible = true;
		badLoseVin.alpha = 0;
		add(badLoseVin);

		loseVin = new FlxSprite(-80).loadGraphic(Paths.image('ui/vin'));
		loseVin.scrollFactor.set();
		loseVin.updateHitbox();
		loseVin.screenCenter();
		loseVin.visible = true;
		loseVin.alpha = 0.2;
		add(loseVin);

		botplayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0,
		"BOTPLAY", 20);
		botplayTxt.setFormat((SONG.song.toLowerCase() == "overdrive") ? Paths.font("ariblk.ttf") : font, 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 3;
		botplayTxt.visible = botPlay;
		add(botplayTxt);

		if (inFiveNights)
		{
			iconP2 = new HealthIcon((formoverride == "none" || formoverride == "bf") ? SONG.player1 : formoverride, false);
			iconP2.y = healthBar.y - (iconP2.height / 2);
			add(iconP2);

			iconP1 = new HealthIcon(SONG.player2 == "bambi" ? "bambi-stupid" : SONG.player2, true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
			add(iconP1);
		}
		else
		{
			iconP1 = new HealthIcon((formoverride == "none" || formoverride == "bf") ? SONG.player1 : formoverride, true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
			add(iconP1);

			iconP2 = new HealthIcon(SONG.player2 == "bambi" ? "bambi-stupid" : SONG.player2, false);
			iconP2.y = healthBar.y - (iconP2.height / 2);
			add(iconP2);
		}
		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		extraTxt.cameras = [camHUD];
		healthTxt.cameras = [camHUD];
		botplayTxt.cameras = [camHUD];
		judgementCounter.cameras = [camHUD];
		if (kadeEngineWatermark != null)
		{
			kadeEngineWatermark.cameras = [camHUD];
			kadeEngineWatermark2.cameras = [camHUD];
			kadeEngineWatermark3.cameras = [camHUD];
		}
		doof.cameras = [camDialogue];
		loseVin.cameras = [camHUD];
		badLoseVin.cameras = [camHUD];

		if (FlxG.save.data.moreScoreInfo){
			judgementCounter.alpha = 0;
			extraTxt.alpha = 0;
			healthTxt.alpha = 0;
		}

		#if SHADERS_ENABLED
		if ((SONG.song.toLowerCase() == 'kabunga' || localFunny == CharacterFunnyEffect.Exbungo) && modchartoption) //i desperately wanted it so if you use downscroll it switches it to upscroll and flips the entire hud upside down but i never got to it
		{
			lazychartshader.waveAmplitude = 0.03;
			lazychartshader.waveFrequency = 5;
			lazychartshader.waveSpeed = 1;

			camHUD.setFilters([new ShaderFilter(lazychartshader.shader)]);
		}
		if (SONG.song.toLowerCase() == 'blocked' || SONG.song.toLowerCase() == 'shredder')
		{
			blockedShader = new BlockedGlitchEffect(1280, 1, 1, true);
		}
		#end
		startingSong = true;
		if (startTimer != null && !startTimer.active)
		{
			startTimer.active = true;
		}
		if (isStoryMode || FlxG.save.data.freeplayCuts || localFunny == CharacterFunnyEffect.Recurser)
		{
			if (hasDialogue)
			{
				schoolIntro(doof);
			}
			else
			{
				if (FlxG.sound.music != null)
					FlxG.sound.music.stop();
				startCountdown();
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				default:
					startCountdown();
			}
		}
		RecalculateRating();

		if (SONG.song.toLowerCase() == "eletric-cockadoodledoo" || SONG.song.toLowerCase() == "electric-cockaldoodledoo" )
		{
			dad.alpha = 0;
		}
		
		if (SONG.song.toLowerCase() == "importumania")
		{
			dad.alpha = 0;
			boyfriend.alpha = 0;
			gf.alpha = 0;
		}
		
		if (SONG.song.toLowerCase() == "foolhardy")
		{
			dad.alpha = 0;
		}
		
		subtitleManager = new SubtitleManager();
		subtitleManager.cameras = [camHUD];
		add(subtitleManager);

		exbungo_funny = FlxG.sound.load(Paths.sound('amen_' + FlxG.random.int(1, 6)));
		exbungo_funny.volume = 0.91;

		hidehphud();

		super.create();

		perlinCamera = new Perlin(Math.floor(Math.random() * 65535));

		Transition.nextCamera = camTransition;
	}
	
	public function createBackgroundSprites(bgName:String, revertedBG:Bool):FlxTypedGroup<BGSprite>
	{
		var sprites:FlxTypedGroup<BGSprite> = new FlxTypedGroup<BGSprite>();
		var bgZoom:Float = 0.7;
		var stageName:String = '';
		switch (bgName)
		{
			case 'house' | 'house-night' | 'house-sunset':
				bgZoom = 0.8;
				
				var skyType:String = '';
				var assetType:String = '';
				switch (bgName)
				{
					case 'house':
						stageName = 'daveHouse';
						skyType = 'sky';
					case 'house-night':
						stageName = 'daveHouse_night';
						skyType = 'sky_night';
						assetType = 'night/';
					case 'house-sunset':
						stageName = 'daveHouse_sunset';
						skyType = 'sky_sunset';
				}
				var bg:BGSprite = new BGSprite('bg', -600, -300, Paths.image('backgrounds/shared/${skyType}'), null, 0.6, 0.6);
				sprites.add(bg);
				add(bg);
				
				var stageHills:BGSprite = new BGSprite('stageHills', -834, -159, Paths.image('backgrounds/dave-house/${assetType}hills'), null, 0.7, 0.7);
				sprites.add(stageHills);
				add(stageHills);

				var grassbg:BGSprite = new BGSprite('grassbg', -1205, 580, Paths.image('backgrounds/dave-house/${assetType}grass bg'), null);
				sprites.add(grassbg);
				add(grassbg);
	
				var gate:BGSprite = new BGSprite('gate', -755, 250, Paths.image('backgrounds/dave-house/${assetType}gate'), null);
				sprites.add(gate);
				add(gate);
	
				var stageFront:BGSprite = new BGSprite('stageFront', -832, 505, Paths.image('backgrounds/dave-house/${assetType}grass'), null);
				sprites.add(stageFront);
				add(stageFront);

				if (SONG.song.toLowerCase() == 'insanity' || SONG.song.toLowerCase() == 'insanity-2.5' || localFunny == CharacterFunnyEffect.Recurser)
				{
					var bg:BGSprite = new BGSprite('bg', -600, -200, Paths.image('backgrounds/void/redsky_insanity'), null, 1, 1, true, true);
					bg.alpha = 0.75;
					bg.visible = false;
					add(bg);
					// below code assumes shaders are always enabled which is bad
					voidShader(bg);
				}
						
				var variantColor = getBackgroundColor(stageName);
				if (stageName != 'daveHouse_night')
				{
					stageHills.color = variantColor;
					grassbg.color = variantColor;
					gate.color = variantColor;
					stageFront.color = variantColor;
				}
		        case 'mastered':
				var bg:BGSprite = new BGSprite('bg', -600, -300, Paths.image('backgrounds/shared/sky_night'), null, 0.6, 0.6);
				sprites.add(bg);
				add(bg);
				
				var stageHills:BGSprite = new BGSprite('stageHills', -834, -159, Paths.image('backgrounds/dave-house/night/hills'), null, 0.7, 0.7);
				sprites.add(stageHills);
				add(stageHills);

				var grassbg:BGSprite = new BGSprite('grassbg', -1205, 580, Paths.image('backgrounds/dave-house/night/grass bg'), null);
				sprites.add(grassbg);
				add(grassbg);
	
				var gate:BGSprite = new BGSprite('gate', -755, 250, Paths.image('backgrounds/dave-house/night/gate'), null);
				sprites.add(gate);
				add(gate);
	
				var stageFront:BGSprite = new BGSprite('stageFront', -832, 505, Paths.image('backgrounds/dave-house/night/grass'), null);
				sprites.add(stageFront);
				add(stageFront);
				
				var blue3d:BGSprite = new BGSprite('blue3d', -275, -200, Paths.image('backgrounds/blue3d', 'shared'), null, 1, 1, true, true);
				new Animation('idle', 'blue3d idle', 5, true, [false, false]);
			        blue3d.animation.play('idle');
				blue3d.visible = false;
				add(blue3d);
					
				var redbg:BGSprite = new BGSprite('redbg', -275, -200, Paths.image('backgrounds/redbg', 'shared'), null, 1, 1, true, true);
				new Animation('idle', 'redbg', 5, true, [false, false]);
			        redbg.animation.play('idle');
				redbg.visible = false;
				add(redbg);

		        case 'detected':
				bgZoom = 0.7;
				curStage = 'detected';

				var hexBack = new FlxSprite(-500, -30).loadGraphic(Paths.image('backgrounds/detected/hexBack'));
				hexBack.antialiasing = true;
				hexBack.scrollFactor.set(0.9, 0.9);
				hexBack.setGraphicSize(Std.int(hexBack.width * 1.5));
				add(hexBack);

				var hexFront = new FlxSprite(-532, 366).loadGraphic(Paths.image('backgrounds/detected/hexFront'));
				hexFront.antialiasing = true;
			        hexFront.scrollFactor.set(0.9, 0.9);
				hexFront.setGraphicSize(Std.int(hexFront.width * 1.5));
			        add(hexFront);

				var topOverlay = new FlxSprite(-450, 90).loadGraphic(Paths.image('backgrounds/detected/topOverlay'));
				topOverlay.antialiasing = true;
				topOverlay.scrollFactor.set(0.9, 0.9);
				topOverlay.setGraphicSize(Std.int(topOverlay.width * 1.5));
			        add(topOverlay);

				var crowd:FlxSprite = new FlxSprite(-450, 90);
				crowd.frames = Paths.getSparrowAtlas('backgrounds/detected/crowd');
				crowd.animation.addByPrefix('bop', 'Symbol 1', 24, false);
				crowd.antialiasing = true;
				crowd.scrollFactor.set(0.9, 0.9);
				crowd.setGraphicSize(Std.int(crowd.width * 1.5));
				add(crowd);

			case 'inside-house':
				bgZoom = 0.6;
				stageName = 'insideHouse';

				var bg:BGSprite = new BGSprite('bg', -1000, -350, Paths.image('backgrounds/inside_house'), null);
				sprites.add(bg);
				add(bg);

			case 'farm' | 'farm-night' | 'farm-sunset':
				bgZoom = 0.8;

				switch (bgName.toLowerCase())
				{
					case 'farm-night':
						stageName = 'bambiFarmNight';
					case 'farm-sunset':
						stageName = 'bambiFarmSunset';
					default:
						stageName = 'bambiFarm';
				}
	
				var skyType:String = stageName == 'bambiFarmNight' ? 'sky_night' : stageName == 'bambiFarmSunset' ? 'sky_sunset' : 'sky';
				
				var bg:BGSprite = new BGSprite('bg', -600, -200, Paths.image('backgrounds/shared/' + skyType), null, 0.6, 0.6);
				sprites.add(bg);
				add(bg);

				if (SONG.song.toLowerCase() == 'maze')
				{
					var sunsetBG:BGSprite = new BGSprite('sunsetBG', -600, -200, Paths.image('backgrounds/shared/sky_sunset'), null, 0.6, 0.6);
					sunsetBG.alpha = 0;
					sprites.add(sunsetBG);
					add(sunsetBG);

					var nightBG:BGSprite = new BGSprite('nightBG', -600, -200, Paths.image('backgrounds/shared/sky_night'), null, 0.6, 0.6);
					nightBG.alpha = 0;
					sprites.add(nightBG);
					add(nightBG);
					if (isStoryMode)
					{
						health -= 0.2;
					}
				}
				var flatgrass:BGSprite = new BGSprite('flatgrass', 350, 75, Paths.image('backgrounds/farm/gm_flatgrass'), null, 0.65, 0.65);
				flatgrass.setGraphicSize(Std.int(flatgrass.width * 0.34));
				flatgrass.updateHitbox();
				sprites.add(flatgrass);
				
				var hills:BGSprite = new BGSprite('hills', -173, 100, Paths.image('backgrounds/farm/orangey hills'), null, 0.65, 0.65);
				sprites.add(hills);
				
				var farmHouse:BGSprite = new BGSprite('farmHouse', 100, 125, Paths.image('backgrounds/farm/funfarmhouse', 'shared'), null, 0.7, 0.7);
				farmHouse.setGraphicSize(Std.int(farmHouse.width * 0.9));
				farmHouse.updateHitbox();
				sprites.add(farmHouse);

				var grassLand:BGSprite = new BGSprite('grassLand', -600, 500, Paths.image('backgrounds/farm/grass lands', 'shared'), null);
				sprites.add(grassLand);

				var cornFence:BGSprite = new BGSprite('cornFence', -400, 200, Paths.image('backgrounds/farm/cornFence', 'shared'), null);
				sprites.add(cornFence);
				
				var cornFence2:BGSprite = new BGSprite('cornFence2', 1100, 200, Paths.image('backgrounds/farm/cornFence2', 'shared'), null);
				sprites.add(cornFence2);

				var bagType = FlxG.random.int(0, 1000) == 0 ? 'popeye' : 'cornbag';
				var cornBag:BGSprite = new BGSprite('cornFence2', 1200, 550, Paths.image('backgrounds/farm/$bagType', 'shared'), null);
				sprites.add(cornBag);
				
				var sign:BGSprite = new BGSprite('sign', 0, 350, Paths.image('backgrounds/farm/sign', 'shared'), null);
				sprites.add(sign);

				var variantColor:FlxColor = getBackgroundColor(stageName);
				
				flatgrass.color = variantColor;
				hills.color = variantColor;
				farmHouse.color = variantColor;
				grassLand.color = variantColor;
				cornFence.color = variantColor;
				cornFence2.color = variantColor;
				cornBag.color = variantColor;
				sign.color = variantColor;
				
				add(flatgrass);
				add(hills);
				add(farmHouse);
				add(grassLand);
				add(cornFence);
				add(cornFence2);
				add(cornBag);
				add(sign);

				if (['blocked', 'corn-theft', 'maze', 'mealie', 'indignancy'].contains(SONG.song.toLowerCase()) && !MathGameState.failedGame && FlxG.random.int(0, 4) == 0)
				{
					FlxG.mouse.visible = true;
					baldi = new BGSprite('baldi', 400, 110, Paths.image('backgrounds/farm/baldo', 'shared'), null, 0.65, 0.65);
					baldi.setGraphicSize(Std.int(baldi.width * 0.31));
					baldi.updateHitbox();
					baldi.color = variantColor;
					sprites.insert(members.indexOf(hills), baldi);
					insert(members.indexOf(hills), baldi);
				}

				if (SONG.song.toLowerCase() == 'splitathon')
				{
					var picnic:BGSprite = new BGSprite('picnic', 1050, 650, Paths.image('backgrounds/farm/picnic_towel_thing', 'shared'), null);
					sprites.insert(sprites.members.indexOf(cornBag), picnic);
					picnic.color = variantColor;
					insert(members.indexOf(cornBag), picnic);
				}
			case 'scrapped-farm' | 'scrapped-farm-night' | 'scrapped-farm-sunset':
				defaultCamZoom = 1.2;

				switch (bgName.toLowerCase())
				{
					case 'scrapped-farm-night':
						curStage = 'scrappedbambiFarmNight';
					case 'scrapped-farm-sunset':
						curStage = 'scrappedbambiFarmSunset';
					default:
						curStage = 'scrappedbambiFarm';
				}
	
				var skyType:String = curStage == 'scrappedbambiFarmNight' ? 'sky_night' : curStage == 'scrappedbambiFarmSunset' ? 'sky_sunset' : 'sky';
				
				var bg:BGSprite = new BGSprite('bg', -400, 0, Paths.image('backgrounds/shared/' + skyType), null, 0.9, 0.9);
				sprites.add(bg);

				if (SONG.song.toLowerCase() == 'maze-2.5')
				{
					var sunsetBG:BGSprite = new BGSprite('sunsetBG', -700, 0, Paths.image('backgrounds/shared/sky_sunset'), null, 0.9, 0.9);
					sunsetBG.alpha = 0;
					add(sunsetBG);
					sprites.add(sunsetBG);

					var nightBG:BGSprite = new BGSprite('nightBG', -700, 0, Paths.image('backgrounds/shared/sky_night'), null, 0.9, 0.9);
					nightBG.alpha = 0;
					add(nightBG);
					sprites.add(nightBG);
				}
				var flatGrass:BGSprite = new BGSprite('flatGrass', 500, 200, Paths.image('backgrounds/farm-scrapped/gm_flatgrass'), null, 0.9, 0.9);
				sprites.add(flatGrass);
				
				var farmHouse:BGSprite = new BGSprite('farmHouse', -700, 50, Paths.image('backgrounds/farm-scrapped/farmhouse'), null, 0.9, 1);
				sprites.add(farmHouse);
				
				var path:BGSprite = new BGSprite('path', -700, 500, Paths.image('backgrounds/farm-scrapped/path'), null);
				sprites.add(path);
				
				var cornMaze:BGSprite = new BGSprite('cornMaze', -300, 200, Paths.image('backgrounds/farm-scrapped/cornmaze'), null);
				sprites.add(cornMaze);
				
				var cornMaze2:BGSprite = new BGSprite('cornMaze2', 1000, 150, Paths.image('backgrounds/farm-scrapped/cornmaze2'), null);
				sprites.add(cornMaze2);
				
				var cornBag:BGSprite = new BGSprite('cornBag', 1150, 500, Paths.image('backgrounds/farm-scrapped/cornbag'), null);
				sprites.add(cornBag);
				
				var variantColor:FlxColor = getBackgroundColor(stageName);
				
				flatGrass.color = variantColor;
				farmHouse.color = variantColor;
				path.color = variantColor;
				cornMaze.color = variantColor;
				cornMaze2.color = variantColor;
				cornBag.color = variantColor;
				
				add(bg);
				add(flatGrass);
				add(farmHouse);
				add(path);
				add(cornMaze);
				add(cornMaze2);
				add(cornBag);
			case 'farm-2.5' | 'farm-night-2.5' | 'farm-sunset-2.5':
				bgZoom = 0.9;

				switch (bgName.toLowerCase())
				{
					case 'farm-night-2.5':
						curStage = 'bambiFarmNight2.5';
					case 'farm-sunset-2.5':
						curStage = 'bambiFarmSunset2.5';
					default:
						curStage = 'bambiFarm2.5';
				}
	
				var skyType:String = curStage == 'scrappedbambiFarmNight' ? 'sky_night' : curStage == 'scrappedbambiFarmSunset' ? 'sky_sunset' : 'sky';
				
				var bg:BGSprite = new BGSprite('bg', -400, 0, Paths.image('backgrounds/shared/' + skyType), null, 0.9, 0.9);
				//sprites.add(bg);
	
				var hills:FlxSprite = new FlxSprite(-250, 200).loadGraphic(Paths.image('backgrounds/farm-2.5/orangey hills'));
				hills.antialiasing = FlxG.save.data.globalAntialiasing;
				hills.scrollFactor.set(0.9, 0.7);
				hills.active = false;
				//sprites.add(hills);
	
				var farm:FlxSprite = new FlxSprite(150, 250).loadGraphic(Paths.image('backgrounds/farm-2.5/funfarmhouse'));
				farm.antialiasing = FlxG.save.data.globalAntialiasing;
				farm.scrollFactor.set(1.1, 0.9);
				farm.active = false;
				//sprites.add(farm);
				
				var foreground:FlxSprite = new FlxSprite(-400, 600).loadGraphic(Paths.image('backgrounds/farm-2.5/grass lands'));
				foreground.antialiasing = FlxG.save.data.globalAntialiasing;
				foreground.active = false;
				//sprites.add(foreground);
				
				var cornSet:FlxSprite = new FlxSprite(-350, 325).loadGraphic(Paths.image('backgrounds/farm-2.5/Cornys'));
				cornSet.antialiasing = FlxG.save.data.globalAntialiasing;
				cornSet.active = false;
				//sprites.add(cornSet);
				
				var cornSet2:FlxSprite = new FlxSprite(1050, 325).loadGraphic(Paths.image('backgrounds/farm-2.5/Cornys'));
				cornSet2.antialiasing = FlxG.save.data.globalAntialiasing;
				cornSet2.active = false;
				//sprites.add(cornSet2);
				
				var fence:FlxSprite = new FlxSprite(-350, 450).loadGraphic(Paths.image('backgrounds/farm-2.5/crazy fences'));
				fence.antialiasing = FlxG.save.data.globalAntialiasing;
				fence.active = false;
				//sprites.add(fence);
	
				var sign:FlxSprite = new FlxSprite(0, 500).loadGraphic(Paths.image('backgrounds/farm-2.5/Sign'));
				sign.antialiasing = FlxG.save.data.globalAntialiasing;
				sign.active = false;
				//sprites.add(sign);

				var variantColor:FlxColor = getBackgroundColor(stageName);

				hills.color = variantColor;
				farm.color = variantColor;
				foreground.color = variantColor;
				cornSet.color = variantColor;
				cornSet2.color = variantColor;
				fence.color = variantColor;
				sign.color = variantColor;
				
				add(bg);
				add(hills);
				add(farm);
				add(foreground);
				add(cornSet);
				add(cornSet2);
				add(fence);
				add(sign);
	
				UsingNewCam = true;
			case 'old-farm' | 'old-farm-night' | 'old-farm-sunset':
				bgZoom = 0.9;

				switch (bgName.toLowerCase())
				{
					case 'old-farm-night':
						curStage = 'oldbambiFarmNight';
					case 'old-farm-sunset':
						curStage = 'oldbambiFarmSunset';
					default:
						curStage = 'oldbambiFarm';
				}

				var skyType:String = curStage == 'oldbambiFarmNight' ? 'sky_night' : curStage == 'oldbambiFarmSunset' ? 'sky_sunset' : 'sky';

				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/shared/' + skyType));
				bg.antialiasing = FlxG.save.data.globalAntialiasing;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				//sprites.add(bg);

				if (SONG.song.toLowerCase() == 'old-Maze')
				{
					var sunsetBG:BGSprite = new BGSprite('sunsetBG', -700, 0, Paths.image('backgrounds/shared/sky_sunset'), null, 0.9, 0.9);
					sunsetBG.antialiasing = FlxG.save.data.globalAntialiasing;
					sunsetBG.alpha = 0;
					add(sunsetBG);
					sprites.add(sunsetBG);
	
					var nightBG:BGSprite = new BGSprite('nightBG', -700, 0, Paths.image('backgrounds/shared/sky_night'), null, 0.9, 0.9);
					nightBG.antialiasing = FlxG.save.data.globalAntialiasing;
					nightBG.alpha = 0;
					add(nightBG);
					sprites.add(nightBG);
				}

				var sun:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/old-farm/sun'));
				sun.antialiasing = FlxG.save.data.globalAntialiasing;
				sun.scrollFactor.set(1, 1);
				sun.active = false;
				//sprites.add(sun);

				var flatgrass:FlxSprite = new FlxSprite(-600, -100).loadGraphic(Paths.image('backgrounds/old-farm/gm_flatgrass'));
				flatgrass.setGraphicSize(Std.int(flatgrass.width * 0.85));
				flatgrass.updateHitbox();
				flatgrass.antialiasing = FlxG.save.data.globalAntialiasing;
				flatgrass.scrollFactor.set(0.7, 0.7);
				flatgrass.active = false;
				//sprites.add(flatgrass);
				
				var hills:FlxSprite = new FlxSprite(-600, -75).loadGraphic(Paths.image('backgrounds/old-farm/background'));
				hills.setGraphicSize(Std.int(hills.width / 1.2));
				hills.updateHitbox();
				hills.antialiasing = FlxG.save.data.globalAntialiasing;
				hills.scrollFactor.set(0.7, 0.7);
				hills.active = false;
				//sprites.add(hills);
				
				var farm:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/old-farm/farm'));
				farm.antialiasing = FlxG.save.data.globalAntialiasing;
				farm.scrollFactor.set(0.9, 0.9);
				farm.active = false;
				//sprites.add(farm);
				
				var corn:FlxSprite = new FlxSprite(-325, 40).loadGraphic(Paths.image('backgrounds/old-farm/corn'));
				corn.setGraphicSize(Std.int(corn.width * 0.75));
				corn.updateHitbox();
				corn.antialiasing = FlxG.save.data.globalAntialiasing;
				corn.scrollFactor.set(0.9, 0.9);
				corn.active = false;
				//sprites.add(corn);
				
				var sign:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/old-farm/sign'));
				sign.antialiasing = FlxG.save.data.globalAntialiasing;
				sign.scrollFactor.set(0.9, 0.9);
				sign.active = false;
				//sprites.add(sign);
				
				var foreground:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/old-farm/foreground'));
				foreground.antialiasing = FlxG.save.data.globalAntialiasing;
				foreground.scrollFactor.set(1, 1);
				foreground.active = false;
				UsingNewCam = true;
				//sprites.add(foreground);

				var variantColor:FlxColor = getBackgroundColor(stageName);
				
				flatgrass.color = variantColor;
				hills.color = variantColor;
				farm.color = variantColor;
				corn.color = variantColor;
				sign.color = variantColor;
				foreground.color = variantColor;

				add(bg);
				add(sun);
				add(flatgrass);
				add(hills);
				add(farm);
				add(corn);
				add(sign);
				add(foreground);
			case 'festival':
				bgZoom = 0.7;
				stageName = 'festival';
				
				var mainChars:Array<Dynamic> = null;
				switch (SONG.song.toLowerCase())
				{
					case 'shredder':
						mainChars = [
							//char name, prefix, size, x, y, flip x
							['dave', 'idle', 0.8, 175, 100],
							['tristan', 'bop', 0.4, 800, 325]
						];
					case 'greetings':
						if (isGreetingsCutscene)
						{
							mainChars = [
								['bambi', 'bambi idle', 0.9, 400, 350],
								['tristan', 'bop', 0.4, 800, 325]
							];
						}
						else
						{
							mainChars = [
								['dave', 'idle', 0.8, 175, 100],
								['bambi', 'bambi idle', 0.9, 700, 350],
							];
						}
					case 'interdimensional':
						mainChars = [
							['bambi', 'bambi idle', 0.9, 400, 350],
							['tristan', 'bop', 0.4, 800, 325]
						];
				}
				var bg:BGSprite = new BGSprite('bg', -400, -230, Paths.image('backgrounds/shared/sky_festival'), null, 0.6, 0.6);
				sprites.add(bg);
				add(bg);

				var flatGrass:BGSprite = new BGSprite('flatGrass', 800, -100, Paths.image('backgrounds/festival/gm_flatgrass'), null, 0.7, 0.7);
				sprites.add(flatGrass);
				add(flatGrass);

				var farmHouse:BGSprite = new BGSprite('farmHouse', -300, -150, Paths.image('backgrounds/festival/farmHouse'), null, 0.7, 0.7);
				sprites.add(farmHouse);
				add(farmHouse);
				
				var hills:BGSprite = new BGSprite('hills', -1000, -100, Paths.image('backgrounds/festival/hills'), null, 0.7, 0.7);
				sprites.add(hills);
				add(hills);

				var corn:BGSprite = new BGSprite('corn', -1000, 120, 'backgrounds/festival/corn', [
					new Animation('corn', 'idle', 5, true, [false, false])
				], 0.85, 0.85, true, true);
				corn.animation.play('corn');
				sprites.add(corn);
				add(corn);

				var cornGlow:BGSprite = new BGSprite('cornGlow', -1000, 120, 'backgrounds/festival/cornGlow', [
					new Animation('cornGlow', 'idle', 5, true, [false, false])
				], 0.85, 0.85, true, true);
				cornGlow.blend = BlendMode.ADD;
				cornGlow.animation.play('cornGlow');
				sprites.add(cornGlow);
				add(cornGlow);
				
				var backGrass:BGSprite = new BGSprite('backGrass', -1000, 475, Paths.image('backgrounds/festival/backGrass'), null, 0.85, 0.85);
				sprites.add(backGrass);
				add(backGrass);
				
				var crowd = new BGSprite('crowd', -500, -150, 'backgrounds/festival/crowd', [
					new Animation('idle', 'crowdDance', 24, true, [false, false])
				], 0.85, 0.85, true, true);
				crowd.animation.play('idle');
				sprites.add(crowd);
				crowdPeople.add(crowd);
				add(crowd);
				
				for (i in 0...mainChars.length)
				{					
					var crowdChar = new BGSprite(mainChars[i][0], mainChars[i][3], mainChars[i][4], 'backgrounds/festival/mainCrowd/${mainChars[i][0]}', [
						new Animation('idle', mainChars[i][1], 24, false, [false, false], null)
					], 0.85, 0.85, true, true);
					crowdChar.setGraphicSize(Std.int(crowdChar.width * mainChars[i][2]));
					crowdChar.updateHitbox();
					sprites.add(crowdChar);
					crowdPeople.add(crowdChar);
					add(crowdChar);
				}
				
				var frontGrass:BGSprite = new BGSprite('frontGrass', -1300, 600, Paths.image('backgrounds/festival/frontGrass'), null, 1, 1);
				sprites.add(frontGrass);
				add(frontGrass);

				var stageGlow:BGSprite = new BGSprite('stageGlow', -450, 300, 'backgrounds/festival/generalGlow', [
					new Animation('glow', 'idle', 5, true, [false, false])
				], 0, 0, true, true);
				stageGlow.blend = BlendMode.ADD;
				stageGlow.animation.play('glow');
				sprites.add(stageGlow);
				add(stageGlow);

			case 'backyard':
				bgZoom = 0.7;
				stageName = 'backyard';

				var festivalSky:BGSprite = new BGSprite('bg', -400, -400, Paths.image('backgrounds/shared/sky_festival'), null, 0.6, 0.6);
				sprites.add(festivalSky);
				add(festivalSky);

				if (SONG.song.toLowerCase() == 'rano')
				{
					var sunriseBG:BGSprite = new BGSprite('sunriseBG', -600, -400, Paths.image('backgrounds/shared/sky_sunrise'), null, 0.6, 0.6);
					sunriseBG.alpha = 0;
					sprites.add(sunriseBG);
					add(sunriseBG);

					var skyBG:BGSprite = new BGSprite('bg', -600, -400, Paths.image('backgrounds/shared/sky'), null, 0.6, 0.6);
					skyBG.alpha = 0;
					sprites.add(skyBG);
					add(skyBG);
				}

				var hills:BGSprite = new BGSprite('hills', -1330, -432, Paths.image('backgrounds/backyard/hills', 'shared'), null, 0.75, 0.75, true);
				sprites.add(hills);
				add(hills);

				var grass:BGSprite = new BGSprite('grass', -800, 150, Paths.image('backgrounds/backyard/supergrass', 'shared'), null, 1, 1, true);
				sprites.add(grass);
				add(grass);

				var gates:BGSprite = new BGSprite('gates', 564, -33, Paths.image('backgrounds/backyard/gates', 'shared'), null, 1, 1, true);
				sprites.add(gates);
				add(gates);
				
				var bear:BGSprite = new BGSprite('bear', -1035, -710, Paths.image('backgrounds/backyard/bearDude', 'shared'), null, 0.95, 0.95, true);
				sprites.add(bear);
				add(bear);

				var house:BGSprite = new BGSprite('house', -1025, -323, Paths.image('backgrounds/backyard/house', 'shared'), null, 0.95, 0.95, true);
				sprites.add(house);
				add(house);

				var grill:BGSprite = new BGSprite('grill', -489, 452, Paths.image('backgrounds/backyard/grill', 'shared'), null, 0.95, 0.95, true);
				sprites.add(grill);
				add(grill);

				var variantColor = getBackgroundColor(stageName);

				hills.color = variantColor;
				bear.color = variantColor;
				grass.color = variantColor;
				gates.color = variantColor;
				house.color = variantColor;
				grill.color = variantColor;
			case 'desktop':
				bgZoom = 0.5;
				stageName = 'desktop';

				expungedBG = new BGSprite('void', -600, -200, '', null, 1, 1, false, true);
				expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/creepyRoom', 'shared'));
				expungedBG.setPosition(0, 200);
				expungedBG.setGraphicSize(Std.int(expungedBG.width * 2));
				expungedBG.scrollFactor.set();
				expungedBG.antialiasing = false;
				sprites.add(expungedBG);
				add(expungedBG);
				voidShader(expungedBG);
			case 'mixed':
				bgZoom = 0.5;
				stageName = 'mixed';

				var bg:BGSprite = new BGSprite('void', -600, -200, '', null, 1, 1, false, true);
				bg.loadGraphic(Paths.image('backgrounds/void/mixed', 'shared'));
				bg.setPosition(0, 200);
				bg.setGraphicSize(Std.int(bg.width * 2));
				bg.scrollFactor.set();
				bg.antialiasing = false;
				sprites.add(bg);
				add(bg);
				voidShader(bg);
			case 'red-void' | 'random-void' | 'green-void' | "banana-hell":
				bgZoom = 0.7;

				var bg:BGSprite = new BGSprite('void', -600, -200, '', null, 1, 1, false, true);
				
				switch (bgName.toLowerCase())
				{
					case 'red-void':
						bgZoom = 0.8;
						bg.loadGraphic(Paths.image('backgrounds/void/redsky', 'shared'));
						stageName = 'daveEvilHouse';
						weirdBG = bg;
					case 'random-void':
						bgZoom = 0.8;
						bg.loadGraphic(Paths.image('backgrounds/void/random', 'shared'));
						stageName = 'random';
						weirdBG = bg;
					case 'green-void':
						stageName = 'cheating';
						bg.loadGraphic(Paths.image('backgrounds/void/cheater'));
						bg.setPosition(-700, -350);
						bg.setGraphicSize(Std.int(bg.width * 2));
						weirdBG = bg;
	
					case 'banana-hell': // this is a Cockey moment
						bg.loadGraphic(Paths.image('backgrounds/void/bananaVoid1'));
					        bg.setPosition(-700, -300);
						bg.setGraphicSize(Std.int(bg.width * 2.55), Std.int(bg.height * 2));
					        weirdBG = bg;
					        stageName = 'banana-land';

				}
				sprites.add(bg);
				add(bg);
				voidShader(bg);
			case 'glitchy-void':
				bgZoom = 0.7;
				stageName = 'unfairness';

				var bg:BGSprite = new BGSprite('void', -600, -200, Paths.image('backgrounds/void/scarybg'), null, 1, 1, true, true);
				bg.setGraphicSize(Std.int(bg.width * 3));
				sprites.add(bg);
				add(bg);

				voidShader(bg);

				if (['unfairness'].contains(SONG.song.toLowerCase()))
				{
					FlxG.mouse.visible = true;
					redPortal = new BGSprite('redPortal', -371, -2, Paths.image('backgrounds/void/redPortal', 'shared'), null, 0.65, 0.65);
					redPortal.setGraphicSize(Std.int(baldi.width * 0.5));
					redPortal.updateHitbox();
					sprites.insert(members.indexOf(bg), redPortal);
					insert(members.indexOf(bg), redPortal);
				}
				
			case 'interdimension-void':
				bgZoom = 0.6;
				stageName = 'interdimension';

				var bg:BGSprite = new BGSprite('void', -700, -350, Paths.image('backgrounds/void/interdimensions/interdimensionVoid'), null, 1, 1, false, true);
				bg.setGraphicSize(Std.int(bg.width * 1.75));
				sprites.add(bg);
				add(bg);

				voidShader(bg);
				
				interdimensionBG = bg;

				for (char in ['ball', 'bimpe', 'maldo', 'memes kids', 'muko', 'ruby man', 'tristan', 'bambi'])
				{
					var bgChar = new FlyingBGChar(char, Paths.image('backgrounds/festival/scaredCrowd/$char'));
					sprites.add(bgChar);
					flyingBgChars.add(bgChar);
				}
				add(flyingBgChars);
			case 'exbungo-land':
				bgZoom = 0.7;
				stageName = 'kabunga';
				
				var bg:BGSprite = new BGSprite('bg', -320, -160, Paths.image('backgrounds/void/exbongo/Exbongo'), null, 1, 1, true, true);
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				sprites.add(bg);
				add(bg);

				var circle:BGSprite = new BGSprite('circle', -30, 550, Paths.image('backgrounds/void/exbongo/Circle'), null);
				sprites.add(circle);	
				add(circle);

				place = new BGSprite('place', 860, -15, Paths.image('backgrounds/void/exbongo/Place'), null);
				sprites.add(place);	
				add(place);

				if (['kabunga'].contains(SONG.song.toLowerCase()) && FlxG.random.int(0, 4) == 0)
				{
					FlxG.mouse.visible = true;
					hat = new BGSprite('hat', -30, 550, 'eletric-cockadoodledoo/hat', [
						new Animation('idle', 'hat', 24, true, [false, false])
					], 1, 1, true, true);
					hat.setGraphicSize(Std.int(hat.width * 0.36));
					hat.animation.play('idle');
					hat.updateHitbox();
					sprites.insert(members.indexOf(circle), hat);
					insert(members.indexOf(circle), hat);
				}
				
				voidShader(bg);
			case 'rapBattle':
				bgZoom = 1;
				stageName = 'rapLand';

				var bg:BGSprite = new BGSprite('rapBG', -640, -360, Paths.image('backgrounds/rapBattle'), null);
				sprites.add(bg);
				add(bg);
			case 'freeplay':
				bgZoom = 0.4;
				stageName = 'freeplay';
				
				darkSky = new BGSprite('darkSky', darkSkyStartPos, 0, Paths.image('recursed/darkSky'), null, 1, 1, true);
				darkSky.scale.set((1 / bgZoom) * 2, 1 / bgZoom);
				darkSky.updateHitbox();
				darkSky.y = (FlxG.height - darkSky.height) / 2;
				add(darkSky);
				
				darkSky2 = new BGSprite('darkSky', darkSky.x - darkSky.width, 0, Paths.image('recursed/darkSky'), null, 1, 1, true);
				darkSky2.scale.set((1 / bgZoom) * 2, 1 / bgZoom);
				darkSky2.updateHitbox();
				darkSky2.x = darkSky.x - darkSky.width;
				darkSky2.y = (FlxG.height - darkSky2.height) / 2;
				add(darkSky2);

				freeplayBG = new BGSprite('freeplay', 0, 0, daveBG, null, 0, 0, true);
				freeplayBG.setGraphicSize(Std.int(freeplayBG.width * 2));
				freeplayBG.updateHitbox();
				freeplayBG.screenCenter();
				freeplayBG.color = FlxColor.multiply(0xFF4965FF, FlxColor.fromRGB(44, 44, 44));
				freeplayBG.alpha = 0;
				add(freeplayBG);
				
				charBackdrop = new FlxBackdrop(Paths.image('recursed/daveScroll'), 1, 1, true, true);
				charBackdrop.antialiasing = true;
				charBackdrop.scale.set(2, 2);
				charBackdrop.screenCenter();
				charBackdrop.color = FlxColor.multiply(charBackdrop.color, FlxColor.fromRGB(44, 44, 44));
				charBackdrop.alpha = 0;
				add(charBackdrop);

				initAlphabet(daveSongs);
			case 'roof':
				bgZoom = 0.8;
				stageName = 'roof';
				var roof:BGSprite = new BGSprite('roof', -584, -397, Paths.image('backgrounds/gm_house5', 'shared'), null, 1, 1, true);
				roof.setGraphicSize(Std.int(roof.width * 2));
				roof.antialiasing = false;
				add(roof);
			case 'bedroom':
				bgZoom = 0.8;
				stageName = 'bedroom';
				
				var sky:BGSprite = new BGSprite('nightSky', -285, 318, Paths.image('backgrounds/bedroom/sky', 'shared'), null, 0.8, 0.8, true);
				sprites.add(sky);
				add(sky);

				var bg:BGSprite = new BGSprite('bg', -687, 0, Paths.image('backgrounds/bedroom/bg', 'shared'), null, 1, 1, true);
				sprites.add(bg);
				add(bg);

				var baldi:BGSprite = new BGSprite('baldi', 788, 788, Paths.image('backgrounds/bedroom/bed', 'shared'), null, 1, 1, true);
				sprites.add(baldi);
				add(baldi);

				tristanInBotTrot = new BGSprite('tristan', 888, 688, 'backgrounds/bedroom/TristanSitting', [
					new Animation('idle', 'daytime', 24, true, [false, false]),
					new Animation('idleNight', 'nighttime', 24, true, [false, false])
				], 1, 1, true, true);
				tristanInBotTrot.setGraphicSize(Std.int(tristanInBotTrot.width * 0.8));
				tristanInBotTrot.animation.play('idle');
				add(tristanInBotTrot);
				if (formoverride == 'tristan' || formoverride == 'tristan-golden' || formoverride == 'tristan-golden-glowing') {
					remove(tristanInBotTrot);	
			    }
			case 'office':
				bgZoom = 0.9;
				stageName = 'office';
				
				var backFloor:BGSprite = new BGSprite('backFloor', -500, -310, Paths.image('backgrounds/office/backFloor'), null, 1, 1);
				sprites.add(backFloor);
				add(backFloor);
			case 'desert':
				bgZoom = 0.5;
				stageName = 'desert';

				var bg:BGSprite = new BGSprite('bg', -900, -400, Paths.image('backgrounds/shared/sky'), null, 0.2, 0.2);
				bg.setGraphicSize(Std.int(bg.width * 2));
				bg.updateHitbox();
				sprites.add(bg);
				add(bg);

				var sunsetBG:BGSprite = new BGSprite('sunsetBG', -900, -400, Paths.image('backgrounds/shared/sky_sunset'), null, 0.2, 0.2);
				sunsetBG.setGraphicSize(Std.int(sunsetBG.width * 2));
				sunsetBG.updateHitbox();
				sunsetBG.alpha = 0;
				sprites.add(sunsetBG);
				add(sunsetBG);
				
				var nightBG:BGSprite = new BGSprite('nightBG', -900, -400, Paths.image('backgrounds/shared/sky_night'), null, 0.2, 0.2);
				nightBG.setGraphicSize(Std.int(nightBG.width * 2));
				nightBG.updateHitbox();
				nightBG.alpha = 0;
				sprites.add(nightBG);
				add(nightBG);
				
				desertBG = new BGSprite('desert', -786, -500, Paths.image('backgrounds/wedcape_from_cali_backlground', 'shared'), null, 1, 1, true);
				desertBG.setGraphicSize(Std.int(desertBG.width * 1.2));
				desertBG.updateHitbox();
				sprites.add(desertBG);
				add(desertBG);

				desertBG2 = new BGSprite('desert2', desertBG.x - desertBG.width, desertBG.y, Paths.image('backgrounds/wedcape_from_cali_backlground', 'shared'), null, 1, 1, true);
				desertBG2.setGraphicSize(Std.int(desertBG2.width * 1.2));
				desertBG2.updateHitbox();
				sprites.add(desertBG2);
				add(desertBG2);
				
				sign = new BGSprite('sign', 500, 450, Paths.image('california/leavingCalifornia', 'shared'), null, 1, 1, true);
				sprites.add(sign);
				add(sign);

				train = new BGSprite('train', -800, 500, 'california/train', [
					new Animation('idle', 'trainRide', 24, true, [false, false])
				], 1, 1, true, true);
				train.animation.play('idle');
				train.setGraphicSize(Std.int(train.width * 2.5));
				train.updateHitbox();
				train.antialiasing = false;
				sprites.add(train);
				add(train);
			case 'master':
				bgZoom = 0.4;
				stageName = 'master';

				var space:BGSprite = new BGSprite('space', -1724, -971, Paths.image('backgrounds/shared/sky_space'), null, 1.2, 1.2);
				space.setGraphicSize(Std.int(space.width * 10));
				space.antialiasing = false;
				sprites.add(space);
				add(space);
	
				var land:BGSprite = new BGSprite('land', 675, 555, Paths.image('backgrounds/dave-house/land'), null, 0.9, 0.9);
				sprites.add(land);
				add(land);
			case 'overdrive':
				bgZoom = 0.8;
				stageName = 'overdrive';

				var stfu:BGSprite = new BGSprite('stfu', -583, -383, Paths.image('backgrounds/stfu'), null, 1, 1);
				sprites.add(stfu);
				add(stfu);
			case 'garrettLand':
				bgZoom = 0.85;
				stageName = 'garrettLand';
				
				var bg:BGSprite = new BGSprite('bg', -50, -300, Paths.image('backgrounds/field/nightSky', 'shared'), null, 0.5, 0.3, true, true);
				bg.antialiasing = FlxG.save.data.globalAntialiasing;
				bg.setGraphicSize(Std.int(bg.width * 2));
				sprites.add(bg);
				add(bg);

				var bgshit:BGSprite = new BGSprite('bgshit', -50, -300, Paths.image('backgrounds/field/blueGradient', 'shared'), null, 0.5, 0.3, true, true);
				bgshit.antialiasing = FlxG.save.data.globalAntialiasing;
				bgshit.setGraphicSize(Std.int(bg.width * 2));
				sprites.add(bgshit);
				add(bgshit);

				var backGrass:BGSprite = new BGSprite('backGrass', 415, -300, Paths.image('backgrounds/field/grass', 'shared'), null, 0.7, 0.5, true, true);
				backGrass.antialiasing = FlxG.save.data.globalAntialiasing;
				backGrass.setGraphicSize(Std.int(backGrass.width * 1.7));
				sprites.add(backGrass);
				add(backGrass);

				var floor:BGSprite = new BGSprite('floor', 550, 370, Paths.image('backgrounds/field/floor', 'shared'), null, 1, 1, true, true);
				floor.antialiasing = FlxG.save.data.globalAntialiasing;
				floor.setGraphicSize(Std.int(floor.width * 2));
				sprites.add(floor);
				add(floor);

				var gate:BGSprite = new BGSprite('gate', 550, 0, Paths.image('backgrounds/field/gates', 'shared'), null, 1.1, 1, true, true);
				gate.antialiasing = FlxG.save.data.globalAntialiasing;
				gate.setGraphicSize(Std.int(gate.width * 2));
				sprites.add(gate);
				add(gate);
			case 'house-older':
				bgZoom = 0.9;
				stageName = 'house-older';
				var assetType:String = '';

				var bg:BGSprite = new BGSprite('davehousebackold', -600, -200, Paths.image('backgrounds/house-older/${assetType}davehousebackold'), null, 0.2, 0.2);
				bg.antialiasing = FlxG.save.data.globalAntialiasing;
				sprites.add(bg);
				add(bg);

				var floor:BGSprite = new BGSprite('davehousefloorold', -425, 625, Paths.image('backgrounds/house-older/${assetType}davehousefloorold'), null, 1.0, 1.0);
				floor.antialiasing = FlxG.save.data.globalAntialiasing;
				floor.setGraphicSize(Std.int(floor.width * 1.3));
				floor.updateHitbox();
				sprites.add(floor);
				add(floor);
			case 'stage_2':
				bgZoom = 0.9;
				stageName = 'stage_2';

				var bg:BGSprite = new BGSprite('bg_lemon', -600, -200, Paths.image('backgrounds/bg_lemon'), null, 0.95, 0.95);
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				bg.antialiasing = FlxG.save.data.globalAntialiasing;
				bg.active = false;
				sprites.add(bg);
				add(bg);
			case 'fuckyouZardyTime':
				bgZoom = 0.9;
				stageName = 'fuckyouZardyTime';

				maze = new BGSprite('Stage', -600, -200, 'backgrounds/Maze', [
					new Animation('idle', 'Stage', 16, true, [false, false])
				], 0.9, 0.9, true, true);
				maze.antialiasing = FlxG.save.data.globalAntialiasing;
				maze.animation.play('idle');
				maze.updateHitbox();
				maze.antialiasing = true;
				sprites.add(maze);
				add(maze);
			default:
				bgZoom = 0.9;
				stageName = 'stage';

				var bg:BGSprite = new BGSprite('bg', -600, -200, Paths.image('backgrounds/stage/stageback'), null, 0.9, 0.9);
				sprites.add(bg);
				add(bg);
	
				var stageFront:BGSprite = new BGSprite('stageFront', -650, 600, Paths.image('backgrounds/stage/stagefront'), null, 0.9, 0.9);
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				sprites.add(stageFront);
				add(stageFront);
	
				var stageCurtains:BGSprite = new BGSprite('stageCurtains', -500, -300, Paths.image('backgrounds/stage/stagecurtains'), null, 1.3, 1.3);
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				sprites.add(stageCurtains);
				add(stageCurtains);
		}
		// that one cuzsie and kapi part of eletric cockadoodledoo
		if (SONG.song.toLowerCase() == "bananacore" || SONG.song.toLowerCase() == "electric-cockaldoodledoo" || SONG.song.toLowerCase() == "eletric-cockadoodledoo")
			{
				var bg:BGSprite = new BGSprite('bg', -600, -200, Paths.image('eletric-cockadoodledoo/kapicuzsie_back'), null, 0.9, 0.9);
				cuzsieKapiEletricCockadoodledoo.push(bg);
				add(bg);
				bg.visible = false;
				bg.antialiasing = FlxG.save.data.globalAntialiasing;
				
				var stageFront:BGSprite = new BGSprite('stageFront', -650, 600, Paths.image('eletric-cockadoodledoo/kapicuzsie_front'), null, 0.9, 0.9);
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				cuzsieKapiEletricCockadoodledoo.push(stageFront);
				add(stageFront);
				stageFront.antialiasing = FlxG.save.data.globalAntialiasing;
				stageFront.visible = false;
			}
			if (SONG.song.toLowerCase() == "importumania") // Bambi
			{
				var flatgrass:BGSprite = new BGSprite('flatgrass', 350, 75, Paths.image('backgrounds/farm/gm_flatgrass'), null, 0.65, 0.65);
				flatgrass.setGraphicSize(Std.int(flatgrass.width * 0.34));
				flatgrass.updateHitbox();
				add(flatgrass);
				bambiFarmDream.push(flatgrass);
				flatgrass.visible = false;
					
				var hills:BGSprite = new BGSprite('hills', -173, 100, Paths.image('backgrounds/farm/orangey hills'), null, 0.65, 0.65);
				add(hills);
				bambiFarmDream.push(hills);
				hills.visible = false;
						
				var farmHouse:BGSprite = new BGSprite('farmHouse', 100, 125, Paths.image('backgrounds/farm/funfarmhouse', 'shared'), null, 0.7, 0.7);
				farmHouse.setGraphicSize(Std.int(farmHouse.width * 0.9));
				farmHouse.updateHitbox();
				add(farmHouse);
				bambiFarmDream.push(farmHouse);
				farmHouse.visible = false;
		
				var grassLand:BGSprite = new BGSprite('grassLand', -600, 500, Paths.image('backgrounds/farm/grass lands', 'shared'), null);
				add(grassLand);
				bambiFarmDream.push(grassLand);
				grassLand.visible = false;
		
				var cornFence:BGSprite = new BGSprite('cornFence', -400, 200, Paths.image('backgrounds/farm/cornFence', 'shared'), null);
				add(cornFence);
				bambiFarmDream.push(cornFence);
				cornFence.visible = false;
					
				var cornFence2:BGSprite = new BGSprite('cornFence2', 1100, 200, Paths.image('backgrounds/farm/cornFence2', 'shared'), null);
				add(cornFence2);
				bambiFarmDream.push(cornFence2);
				cornFence2.visible = false;
		
				var bagType = FlxG.random.int(0, 1000) == 0 ? 'popeye' : 'cornbag';
				var cornBag:BGSprite = new BGSprite('cornFence2', 1200, 550, Paths.image('backgrounds/farm/$bagType', 'shared'), null);
				add(cornBag);
				bambiFarmDream.push(cornBag);
				cornBag.visible = false;
						
				var sign:BGSprite = new BGSprite('sign', 0, 350, Paths.image('backgrounds/farm/sign', 'shared'), null);
				add(sign);
				bambiFarmDream.push(sign);
				sign.visible = false;
			}
			if (SONG.song.toLowerCase() == "importumania") // Dave
			{
				var assetType:String = '';
		
				var stageHills:BGSprite = new BGSprite('stageHills', -834, -159, Paths.image('backgrounds/dave-house/${assetType}hills'), null, 0.7, 0.7);
				add(stageHills);
				daveHouseDream.push(stageHills);
				stageHills.visible = false;
		
				var grassbg:BGSprite = new BGSprite('grassbg', -1205, 580, Paths.image('backgrounds/dave-house/${assetType}grass bg'), null);
				add(grassbg);
				daveHouseDream.push(grassbg);
				grassbg.visible = false;
			
				var gate:BGSprite = new BGSprite('gate', -755, 250, Paths.image('backgrounds/dave-house/${assetType}gate'), null);
				add(gate);
				daveHouseDream.push(gate);
				gate.visible = false;
			
				var stageFront:BGSprite = new BGSprite('stageFront', -832, 505, Paths.image('backgrounds/dave-house/${assetType}grass'), null);
				add(stageFront);
				daveHouseDream.push(stageFront);
				stageFront.visible = false;
			}
			if (SONG.song.toLowerCase() == "importumania") // Tristan
			{
				var bg:BGSprite = new BGSprite('bg', -1000, -350, Paths.image('backgrounds/inside_house'), null);
				sprites.add(bg);
				add(bg);
				tristanHouseDream.push(bg);
				bg.visible = false;
			}
		if (!revertedBG)
		{
			defaultCamZoom = bgZoom;
			curStage = stageName;
		}

		return sprites;
	}
	static public function quickSpin(sprite)
	{
		FlxTween.angle(sprite, 0, 360, 0.5, {
			type: FlxTween.ONESHOT,
			ease: FlxEase.quadInOut,
			startDelay: 0,
			loopDelay: 0
		});
	}
	public function getBackgroundColor(stage:String):FlxColor
	{
		var variantColor:FlxColor = FlxColor.WHITE;
		switch (stage)
		{
			case 'bambiFarmNight' | 'daveHouse_night' | 'daveHouse_night25' | 'backyard' | 'bedroomNight':
				variantColor = nightColor;
			case 'bambiFarmSunset' | 'daveHouse_sunset' | 'scrappedbambiFarmSunset' | 'oldbambiFarmSunset':
				variantColor = sunsetColor;
			default:
				variantColor = FlxColor.WHITE;
		}
		return variantColor;
	}

	function schoolIntro(?dialogueBox:DialogueBox, isStart:Bool = true):Void
	{
		inCutscene = true;
		camFollow.setPosition(boyfriend.getGraphicMidpoint().x - 200, dad.getGraphicMidpoint().y - 10);
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var stupidBasics:Float = 1;
		if (isStart)
		{
			FlxTween.tween(black, {alpha: 0}, stupidBasics);
		}
		else
		{
			black.alpha = 0;
			stupidBasics = 0;
		}
		new FlxTimer().start(stupidBasics, function(fuckingSussy:FlxTimer)
		{
			if (dialogueBox != null)
			{
				add(dialogueBox);
			}
			else
			{
				startCountdown();
			}
		});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	function voidShader(background:BGSprite)
	{
		#if SHADERS_ENABLED
		var testshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
		testshader.waveAmplitude = 0.1;
		testshader.waveFrequency = 5;
		testshader.waveSpeed = 2;
		
		background.shader = testshader.shader;
		#end
		curbg = background;
	}
	function changeInterdimensionBg(type:String)
	{
		for (sprite in backgroundSprites)
		{
			backgroundSprites.remove(sprite);
			remove(sprite);
		}
		interdimensionBG = new BGSprite('void', -600, -200, '', null, 1, 1, false, true);
		backgroundSprites.add(interdimensionBG);
		add(interdimensionBG);
		switch (type)
		{
			case 'interdimension-void':
				interdimensionBG.loadGraphic(Paths.image('backgrounds/void/interdimensions/interdimensionVoid'));
				interdimensionBG.setPosition(-700, -350);
				interdimensionBG.setGraphicSize(Std.int(interdimensionBG.width * 1.75));
			case 'spike-void':
				interdimensionBG.loadGraphic(Paths.image('backgrounds/void/interdimensions/spike'));
				interdimensionBG.setPosition(-200, 0);
				interdimensionBG.setGraphicSize(Std.int(interdimensionBG.width * 3));
			case 'darkSpace':
				interdimensionBG.loadGraphic(Paths.image('backgrounds/void/interdimensions/darkSpace'));
				interdimensionBG.setPosition(-200, 0);
				interdimensionBG.setGraphicSize(Std.int(interdimensionBG.width * 2.75));
			case 'hexagon-void':
				interdimensionBG.loadGraphic(Paths.image('backgrounds/void/interdimensions/hexagon'));
				interdimensionBG.setPosition(-200, 0);
				interdimensionBG.setGraphicSize(Std.int(interdimensionBG.width * 3));
			case 'nimbi-void':
				interdimensionBG.loadGraphic(Paths.image('backgrounds/void/interdimensions/nimbi/nimbiVoid'));
				interdimensionBG.setPosition(-200, 0);
				interdimensionBG.setGraphicSize(Std.int(interdimensionBG.width * 2.75));
		}
		voidShader(interdimensionBG);
		currentInterdimensionBG = type;
	}
	function startCountdown():Void
	{
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;
		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			boyfriend.dance();
			crowdPeople.forEach(function(crowdPerson:BGSprite)
			{
				crowdPerson.animation.play('idle', true);
			});

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			var introSoundAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			var soundAssetsAlt:Array<String> = new Array<String>();

			if (SONG.song.toLowerCase() == "exploitation")
				introAssets.set('default', ['ui/ready', "ui/set", "ui/go_glitch"]);
			else if (SONG.song.toLowerCase() == "overdrive")
				introAssets.set('default', ['ui/spr_start_sprites_0', "ui/spr_start_sprites_1", "ui/spr_start_sprites_2"]);
			else
				introAssets.set('default', ['ui/ready', "ui/set", "ui/go"]);

			introSoundAssets.set('default', ['default/intro3', 'default/intro2', 'default/intro1', 'default/introGo']);
			introSoundAssets.set('pixel', ['pixel/intro3-pixel', 'pixel/intro2-pixel', 'pixel/intro1-pixel', 'pixel/introGo-pixel']);
			introSoundAssets.set('dave', ['dave/intro3_dave', 'dave/intro2_dave', 'dave/intro1_dave', 'dave/introGo_dave']);
			introSoundAssets.set('bambi', ['bambi/intro3_bambi', 'bambi/intro2_bambi', 'bambi/intro1_bambi', 'bambi/introGo_bambi']);
			introSoundAssets.set('ex', ['default/intro3', 'default/intro2', 'default/intro1', 'ex/introGo_weird']);
			introSoundAssets.set('overdriving', ['dave/intro1_dave', 'dave/intro2_dave', 'dave/intro3_dave', 'dave/introGo_dave']);

			switch (SONG.song.toLowerCase())
			{
				case 'house' | 'insanity' | 'polygonized' | 'old-house' | 'old-insanity' | 'furiosity' | 'bonus-song' | 'interdimensional' | 'five-nights' | 'bonus-song-2.5'|
				'memory' | 'vs-dave-rap' | 'vs-dave-rap-two' | 'house-2.5' | 'insanity-2.5' | 'polygonized-2.5' | 'roots' | 'blitz' | 'no-legs' | 'cob' | 'super-saiyan':
					soundAssetsAlt = introSoundAssets.get('dave');
				case 'blocked' | 'old-blocked' | 'cheating' | 'corn-theft' | 'old-corn-theft' | 'glitch' | 'old-glitch' | 'maze' | 'old-maze' | 'ceta-maze' | 'mealie' | 'secret' |
				'shredder' | 'supernovae' | 'old-supernovae' | 'unfairness' | 'blocked-2.5' | 'corn-theft-2.5' | 'maze-2.5' | 'old-Screwed' | 'screwed-V2' | 'crop'  | 'duper'  | 'popcorn' |
				'rigged' | 'foolhardy' | 'vs-dave-thanksgiving':
					soundAssetsAlt = introSoundAssets.get('bambi');
				case 'exploitation':
					soundAssetsAlt = introSoundAssets.get('ex');
				case 'overdrive':
					soundAssetsAlt = introSoundAssets.get('overdriving');	
				default:
					soundAssetsAlt = introSoundAssets.get('default');
			}

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			var doing_funny:Bool = true;

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)
			{
				case 0:
					FlxG.sound.play(Paths.sound('introSounds/' + soundAssetsAlt[0]), 0.6);
					if (doing_funny)
					{
						focusOnDadGlobal = false;
						ZoomCam(false);
					}
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();
					ready.antialiasing = true;

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {alpha: 0, 'scale.x': ready.scale.x * 0.75, 'scale.y': ready.scale.y * 0.75}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(ready);
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introSounds/' + soundAssetsAlt[1]), 0.6);
					if (doing_funny)
					{
						focusOnDadGlobal = true;
						ZoomCam(true);
					}
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();
			
					set.screenCenter();

					set.antialiasing = true;
					add(set);
					FlxTween.tween(set, {alpha: 0, 'scale.x': set.scale.x * 0.75, 'scale.y': set.scale.y * 0.75}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(set);
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introSounds/' + soundAssetsAlt[2]), 0.6);
					if (doing_funny)
					{
						focusOnDadGlobal = false;
						ZoomCam(false);
					}
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					go.updateHitbox();

					go.screenCenter();

					go.antialiasing = true;
					add(go);

					var sex:Float = 1000;

					if (SONG.song.toLowerCase() == "exploitation")
					{
						sex = 300;
					}

					FlxTween.tween(go, {alpha: 0, 'scale.x': go.scale.x * 0.75, 'scale.y': go.scale.y * 0.75}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(go);
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introSounds/' + soundAssetsAlt[3]), 0.6);
					showhphud();

					strumLineNotes.forEach(function(note)
					{
						quickSpin(note);
					});

					if (doing_funny)
					{
						focusOnDadGlobal = true;
						ZoomCam(true);
					}
				case 4:
					if (!isGreetingsCutscene)
					{
						creditsPopup = new CreditsPopUp(FlxG.width, 200);
						creditsPopup.camera = camHUD;
						creditsPopup.scrollFactor.set();
						creditsPopup.x = creditsPopup.width * -1;
						add(creditsPopup);
	
						FlxTween.tween(creditsPopup, {x: 0}, 0.5, {ease: FlxEase.backOut, onComplete: function(tweeen:FlxTween)
						{
							FlxTween.tween(creditsPopup, {x: creditsPopup.width * -1} , 1, {ease: FlxEase.backIn, onComplete: function(tween:FlxTween)
							{
								creditsPopup.destroy();
							}, startDelay: 3});
						}});
					}
					if (['polygonized', 'interdimensional', 'five-nights'].contains(SONG.song.toLowerCase()) && localFunny != CharacterFunnyEffect.Recurser)
					{
						var shapeNoteWarning = new FlxSprite(0, FlxG.height * 2).loadGraphic(Paths.image(!inFiveNights ? 'ui/shapeNoteWarning' : 'ui/doorWarning'));
						shapeNoteWarning.cameras = [camHUD];
						shapeNoteWarning.scrollFactor.set();
						shapeNoteWarning.antialiasing = false;
						shapeNoteWarning.alpha = 0;
						add(shapeNoteWarning);

						FlxTween.tween(shapeNoteWarning, {alpha: 1}, 1);
						FlxTween.tween(shapeNoteWarning, {y: 450}, 1, {ease: FlxEase.backOut, 
							onComplete: function(tween:FlxTween)
							{
								new FlxTimer().start(2, function(timer:FlxTimer)
								{
									FlxTween.tween(shapeNoteWarning, {alpha: 0}, 1);
									FlxTween.tween(shapeNoteWarning, {y: FlxG.height * 2}, 1, {
										ease: FlxEase.backIn,
										onComplete: function(tween:FlxTween)
										{
											remove(shapeNoteWarning);
										}
									});
								});
							}
						});
					}
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	function playCutscene(name:String)
	{
		inCutscene = true;
		FlxG.sound.music.stop();

		video = new MP4Handler();
		video.finishCallback = function()
		{
			switch (curSong.toLowerCase())
			{
				case 'house':
					var doof:DialogueBox = new DialogueBox(false, dialogue, isStoryMode);
					// doof.x += 70;
					// doof.y = FlxG.height * 0.5;
					doof.scrollFactor.set();
					doof.finishThing = startCountdown;
					schoolIntro(doof);
				default:
					startCountdown();
			}
		}
		video.playVideo(Paths.video(name));
	}

	function playEndCutscene(name:String)
	{
		inCutscene = true;

		video = new MP4Handler();
		video.finishCallback = function()
		{
			LoadingState.loadAndSwitchState(new PlayState());
		}
		video.playVideo(Paths.video(name));
	}

	var previousFrameTime:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;

		if (!paused)
		{
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
			vocals.play();
		}
		for (tween in tweenList)
		{
			tween.active = true;
		}
		activateSunTweens = true;

		#if desktop
		DiscordClient.changePresence(detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") ",
			"\nAcc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC);
		#end
		FlxG.sound.music.onComplete = endSong;
		if (songPosBar != null)
		{
			songPosBar.setRange(0, FlxG.sound.music.length);
		}
		if (songName != null && barType == 'ShowTime')
		{
			FlxTween.tween(songName, {alpha: 1}, 1);
		}
		switch (SONG.song.toLowerCase())
		{
			case 'escape-from-california':
				dad.canSing = false;
				dad.canDance = false;
				dad.playAnim('helpMe', true);
				dad.animation.finishCallback = function(anim:String)
				{
					dad.canSing = true;
					dad.canDance = true;
				}
				FlxTween.num(0, 30, 2, {}, function(newValue:Float)
				{
					trainSpeed = newValue;
					train.animation.curAnim.frameRate = Std.int(FlxMath.lerp(0, 24, (trainSpeed / 30)));
				});
			case 'supernovae' | 'glitch' | 'master':
				Application.current.window.title = banbiWindowNames[new FlxRandom().int(0, banbiWindowNames.length - 1)];
			case 'exploitation':
				blackScreen = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				blackScreen.cameras = [camHUD];
				blackScreen.screenCenter();
				blackScreen.scrollFactor.set();
				blackScreen.alpha = 0;
				add(blackScreen);
					
				Application.current.window.title = "[DATA EXPUNGED]";
				Application.current.window.setIcon(lime.graphics.Image.fromFile("art/icons/iconAAAA.png"));
			case 'vs-dave-rap' | 'vs-dave-rap-two':
				FlxTween.tween(blackScreen, {alpha: 0}, 3, {onComplete: function(tween:FlxTween)
				{
					remove(blackScreen);
				}});
			case 'five-nights':
				FlxG.mouse.visible = true;
			case 'greetings':
				if (isGreetingsCutscene)
				{
					generatedMusic = false;
					vocals.stop();
					vocals.volume = 0;
					FlxG.sound.music.onComplete = null;
					FlxG.sound.music.stop();
					for (note in unspawnNotes)
					{
						unspawnNotes.remove(note);
					}
					greetingsCutscene();
				}
			case 'indignancy':
				vignette = new FlxSprite().loadGraphic(Paths.image('vignette'));
				vignette.screenCenter();
				vignette.scrollFactor.set();
				vignette.cameras = [camHUD];
				vignette.alpha = 0;
				add(vignette);
				FlxTween.tween(vignette, {alpha: 0.7}, 1);
		}
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song, localFunny == CharacterFunnyEffect.Tristan ? "-Tristan" : shaggyVoice ? "Shaggy" : ""));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		for (section in noteData)
		{
			var sectionCount = noteData.indexOf(section);

			var isGuitarSection = (sectionCount >= 64 && sectionCount < 80) && SONG.song.toLowerCase() == 'shredder'; //wtf

			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % (isGuitarSection ? 5 : Main.keyAmmo[mania]));
				var OGNoteDat = daNoteData;
				if (localFunny == CharacterFunnyEffect.Bambi)
				{
					daNoteData = 2;
				}
				var daNoteStyle:String = songNotes[3];
				if (localFunny == CharacterFunnyEffect.Recurser)
				{
					daNoteStyle = 'normal';
				}

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > (isGuitarSection ? 4 : Main.keyAmmo[mania] - 1))
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, gottaHitNote, daNoteStyle, false, isGuitarSection);
				swagNote.originalType = OGNoteDat;
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				var floorSus:Int = Math.floor(susLength);
				if (floorSus > 0) {
					for (susNote in 0...floorSus+1)
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
	
						var notespd = SONG.speed;
						if (SONG.song.toLowerCase() == "exploitation") notespd = SONG.speed * 3;
						var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(notespd, 2)), daNoteData, oldNote, true,
							gottaHitNote, daNoteStyle, false, isGuitarSection);
						sustainNote.originalType = OGNoteDat;
						sustainNote.scrollFactor.set();
						unspawnNotes.push(sustainNote);
	
						sustainNote.mustPress = gottaHitNote;
					}
				}

				swagNote.mustPress = gottaHitNote;
			}
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function generateStaticArrows(player:Int, regenerate:Bool = false, fadeIn:Bool = true):Void
	{
		var note_order:Array<Int> = [0,1,2,3];
		if (mania == 1) note_order = [0, 1, 2, 3, 4];
		if (mania == 2) note_order = [0, 1, 2, 3, 4, 5];
		if (mania == 3) note_order = [0, 1, 2, 3, 4, 5, 6];
		if (mania == 4) note_order = [0, 1, 2, 3, 4, 5, 6, 7, 8];
		if (mania == 5) note_order = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
		if (localFunny == CharacterFunnyEffect.Bambi)
		{
			note_order = [2,2,2,2];
		}
		else if (localFunny == CharacterFunnyEffect.Tristan)
		{
			note_order = [0,3,2,1];
		}
		for (i in 0...Main.keyAmmo[mania])
		{
			var arrowType:Int = note_order[i];
			var strumType:String = '';
			if ((funnyFloatyBoys.contains(dad.curCharacter) || dad.curCharacter == "nofriend") && player == 0 || funnyFloatyBoys.contains(boyfriend.curCharacter) && player == 1)
			{
				strumType = '3D';
			}
			else
			{
				switch (curStage)
				{
					default:
						if (SONG.song.toLowerCase() == "overdrive")
							strumType = 'top10awesome';
				}
			}
			if (pressingKey5Global)
			{
				strumType = 'shape';
			}
			var babyArrow:StrumNote = new StrumNote(0, strumLine.y, strumType, arrowType, player == 1);

			if (!isStoryMode && fadeIn)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}
			babyArrow.x += Note.swagWidth * Math.abs(i);
			babyArrow.x += 78 + 78 / 4; // playerStrumAmount
			babyArrow.x += ((FlxG.width / 2) * player);
			babyArrow.x -= Note.posRest[mania];
			babyArrow.playAnim('static');
			
			babyArrow.baseX = babyArrow.x;
			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				dadStrums.add(babyArrow);
			}
			strumLineNotes.add(babyArrow);
		}
	}
	function generateGhNotes(player:Int)
	{
		for (i in 0...5)
		{
			var arrowType:Int = i;
			if (localFunny == CharacterFunnyEffect.Bambi)
			{
				arrowType = 2;
			}
			var babyArrow:StrumNote = new StrumNote(0, strumLine.y, 'gh', i, false);

			babyArrow.x += 160 * 0.7 * Math.abs(i);
			babyArrow.x += 78;
			babyArrow.baseX = babyArrow.x;
			dadStrums.add(babyArrow);
			strumLineNotes.add(babyArrow);
		}
	}
	function regenerateStaticArrows(player:Int, fadeIn = true)
	{
		switch (player)
		{
			case 0:
				dadStrums.forEach(function(spr:StrumNote)
				{
					dadStrums.remove(spr);
					strumLineNotes.remove(spr);
					remove(spr);
					spr.destroy();
				});
			case 1:
				playerStrums.forEach(function(spr:StrumNote)
				{
					playerStrums.remove(spr);
					strumLineNotes.remove(spr);
					remove(spr);
					spr.destroy();
				});
		}
		generateStaticArrows(player, false, fadeIn);
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.sineInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
				if (exbungo_funny != null)
				{
					exbungo_funny.pause();
				}
			}
			if (tweenList != null && tweenList.length != 0)
			{
				for (tween in tweenList)
				{
					if (!tween.finished)
					{
						tween.active = false;
					}
				}
			}
			if (rotatingCamTween != null)
			{
				rotatingCamTween.active = false;
			}
			for (tween in pauseTweens)
			{
				tween.active = false;
			}
			
			#if desktop
			DiscordClient.changePresence("PAUSED on "
				+ SONG.song
				+ " ("
				+ storyDifficultyText
				+ ") |",
				"Acc: "
				+ truncateFloat(accuracy, 2)
				+ "% | Score: "
				+ songScore
				+ " | Misses: "
				+ misses, iconRPC);
			#end
			if (startTimer != null && !startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	public function throwThatBitchInThere(guyWhoComesIn:String = 'bambi', guyWhoFliesOut:String = 'dave')
	{
		hasTriggeredDumbshit = true;
		if(BAMBICUTSCENEICONHURHURHUR != null)
		{
			remove(BAMBICUTSCENEICONHURHURHUR);
		}
		BAMBICUTSCENEICONHURHURHUR = new HealthIcon(guyWhoComesIn, false);
		BAMBICUTSCENEICONHURHURHUR.changeState(iconP2.getState());
		BAMBICUTSCENEICONHURHURHUR.y = healthBar.y - (BAMBICUTSCENEICONHURHURHUR.height / 2);
		add(BAMBICUTSCENEICONHURHURHUR);
		BAMBICUTSCENEICONHURHURHUR.cameras = [camHUD];
		BAMBICUTSCENEICONHURHURHUR.x = -100;
		FlxTween.linearMotion(BAMBICUTSCENEICONHURHURHUR, -100, BAMBICUTSCENEICONHURHURHUR.y, iconP2.x, BAMBICUTSCENEICONHURHURHUR.y, 0.3, true, {ease: FlxEase.expoInOut});
		AUGHHHH = guyWhoComesIn;
		AHHHHH = guyWhoFliesOut;
		new FlxTimer().start(0.3, FlingCharacterIconToOblivionAndBeyond);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = true;

			if (tweenList != null && tweenList.length != 0)
			{
				for (tween in tweenList)
				{
					if (!tween.finished && activateSunTweens)
					{
						tween.active = true;
					}
				}
			}
			if (rotatingCamTween != null)
			{
				rotatingCamTween.active = true;
			}
			for (tween in pauseTweens)
			{
				tween.active = true;
			}
			paused = false;

			if (startTimer != null && startTimer.finished)
			{
				#if desktop
				DiscordClient.changePresence(detailsText
					+ " "
					+ SONG.song
					+ " ("
					+ storyDifficultyText
					+ ") ",
					"\nAcc: "
					+ truncateFloat(accuracy, 2)
					+ "% | Score: "
					+ songScore
					+ " | Misses: "
					+ misses, iconRPC, true,
					FlxG.sound.music.length
					- Conductor.songPosition);
				#end
			}
			else
			{
				#if desktop
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") ", iconRPC);
				#end
			}
		}

		super.closeSubState();
	}

	function resyncVocals():Void
	{
		vocals.pause();
		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if desktop
		DiscordClient.changePresence(detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") ",
			"\nAcc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC);
		#end
	}

	public static var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;
	private var perlinCamera:Perlin;
	private var perlinElapsed:FlxPoint;
	private var exploPart:Bool = false;
	private var unfairPart:Bool = false;
	private var cheatPart:Bool = false;
	var nps:Int = 0;
	var maxNPS:Int = 0;

	function truncateFloat(number:Float, precision:Int):Float
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round(num) / Math.pow(10, precision);
		return num;
	}

	override public function update(elapsed:Float)
	{
		for(i in 0...notesHitArray.length)
		{
			var cock:Date = notesHitArray[i];
			if (cock != null)
				if (cock.getTime() + 2000 < Date.now().getTime())
				notesHitArray.remove(cock);
		}
		nps = Math.floor(notesHitArray.length / 2);
		if (nps > maxNPS)
			maxNPS = nps;
		
		if (perlinElapsed == null)
			perlinElapsed = FlxPoint.get();

		elapsedtime += elapsed;

		if (shaggyT != null) {
			shaggyT.color = boyfriend.color;
			shaggyT.visible = boyfriend.alpha >= 0.5;
		}
		if (boyfriend.curCharacter == 'godshaggy') {
			legs.color = boyfriend.color;
			legT.color = boyfriend.color;

			var rotRateSh = curStep / 9.5;
			var sh_toy = shy + -Math.sin(rotRateSh * 2) * sh_r * 0.45;
			var sh_tox = shx -Math.cos(rotRateSh) * sh_r;
			boyfriend.x += (sh_tox - boyfriend.x) / 12;
			boyfriend.y += (sh_toy - boyfriend.y) / 12;

			if (boyfriend.animation.name == 'idle')
			{
				var pene = 0.07;
				boyfriend.angle = Math.sin(rotRateSh) * sh_r * pene / 4;

				legs.alpha = boyfriend.alpha;
				legT.visible = boyfriend.alpha >= 0.5;
				legs.angle = Math.sin(rotRateSh) * sh_r * pene;

				legs.x = boyfriend.x + 150 + Math.cos((legs.angle + 90) * (Math.PI/180)) * 150;
				legs.y = boyfriend.y + 300 + Math.sin((legs.angle + 90) * (Math.PI/180)) * 150;
			}
			else
			{
				boyfriend.angle = 0;
				legs.alpha = 0;
				legT.visible = false;
			}
		}

		if (songName != null && barType == 'ShowTime')
		{
			songName.text = FlxStringUtil.formatTime((FlxG.sound.music.length - FlxG.sound.music.time) / 1000);
		}

		if (startingSong && startTimer != null && !startTimer.active)
			startTimer.active = true;

		if (localFunny == CharacterFunnyEffect.Exbungo)
		{
			FlxG.sound.music.volume = 0;
			exbungo_funny.play();
		}
			
		if (paused && FlxG.sound.music != null && vocals != null && vocals.playing)
		{
			FlxG.sound.music.pause();
			vocals.pause();
		}
		if (curbg != null)
		{
			if (curbg.active) // only the polygonized background is active
			{
				#if SHADERS_ENABLED
				var shad = cast(curbg.shader, Shaders.GlitchShader);
				shad.uTime.value[0] += elapsed;
				#end
			}
		}
		if (SONG.song.toLowerCase() == 'escape-from-california')
		{
			var scrollSpeed = 100;
			if (desertBG != null)
			{
				desertBG.x -= trainSpeed * scrollSpeed * elapsed;
			
				if (desertBG.x <= -(desertBG.width) + (desertBG.width - 1280))
				{
					desertBG.x = desertBG.width - 1280;
				}
				desertBG2.x = desertBG.x - desertBG.width;
				desertBG2.y = desertBG.y;
			}
			
			if (sign != null)
			{
				sign.x -= trainSpeed * scrollSpeed * elapsed;
			}
			if (georgia != null)
			{
				georgia.x -= trainSpeed * scrollSpeed * elapsed;
			}
		}

		if (SONG.song.toLowerCase() == 'recursed')
		{
			var scrollSpeed = 150;
			charBackdrop.x -= scrollSpeed * elapsed;
			charBackdrop.y += scrollSpeed * elapsed;

			darkSky.x += 40 * scrollSpeed * elapsed;
			if (darkSky.x >= (darkSkyStartPos * 4) - 1280)
			{
				darkSky.x = resetPos;
			}
			darkSky2.x = darkSky.x - darkSky.width;
			
			var lerpVal = 0.97;
			freeplayBG.alpha = FlxMath.lerp(0, freeplayBG.alpha, lerpVal);
			charBackdrop.alpha = FlxMath.lerp(0, charBackdrop.alpha, lerpVal);
			for (char in alphaCharacters)
			{
				for (letter in char.characters)
				{
					letter.alpha = FlxMath.lerp(0, letter.alpha, lerpVal);
				}
			}
			if (isRecursed)
			{
				timeLeft -= elapsed;
				if (timeLeftText != null)
				{
					timeLeftText.text = FlxStringUtil.formatTime(Math.floor(timeLeft));
				}

				camRotateAngle += elapsed * 5 * (rotateCamToRight ? 1 : -1);

				FlxG.camera.angle = camRotateAngle;
				camHUD.angle = camRotateAngle;

				if (camRotateAngle > 8)
				{
					rotateCamToRight = false;
				}
				else if (camRotateAngle < -8)
				{
					rotateCamToRight = true;
				}
				
				health = FlxMath.lerp(0, 2, timeLeft / timeGiven);
			}
			else
			{
				if (FlxG.camera.angle > 0 || camHUD.angle > 0)
				{
					cancelRecursedCamTween();
				}
			}
		}
		if (SONG.song.toLowerCase() == 'interdimensional')
		{
			var speed = 300;
			flyingBgChars.forEach(function(bgChar:FlyingBGChar)
			{
				var moveDir = bgChar.direction == 'left' ? -1 : bgChar.direction == 'right' ? 1 : 0;
				bgChar.x += speed * elapsed * moveDir * bgChar.randomSpeed;
				bgChar.y += (Math.sin(elapsedtime) * 5);
	
				bgChar.angle += bgChar.angleChangeAmount * elapsed;

				switch (bgChar.direction)
				{
					case 'left':
						if (bgChar.x < bgChar.leftPosCheck)
						{
							bgChar.switchDirection();
						}
					case 'right':
						if (bgChar.x > bgChar.rightPosCheck)
						{
							bgChar.switchDirection();
						}
				}
			});
		}
		if (SONG.song.toLowerCase() == 'five-nights')
		{
			powerLeft = Math.max(powerLeft - (elapsed / 3) * powerDrainer, 0);
			powerLeftText.text = 'Power Left: ${Math.floor(powerLeft)}%';
			if (powerLeft <= 0 && !powerRanOut && curStep < 1088)
			{
				powerRanOut = true;
				
				boyfriend.stunned = true;
				deathCounter++;

				persistentUpdate = false;
				persistentDraw = false;
				paused = true;
	
				vocals.volume = 0;
				FlxG.sound.music.volume = 0;

				FlxTween.tween(camHUD, {alpha: 0}, 1);
				
				for (note in unspawnNotes)
				{
					unspawnNotes.remove(note);
				}

				var black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				black.scrollFactor.set();
				black.screenCenter();
				add(black);

				powerDown = new FlxSound().loadEmbedded(Paths.sound('fiveNights/powerOut', 'shared'));
				powerDown.play();
			}
			if (powerRanOut)
			{
				curStep < 1088 ? {
					new FlxTimer().start(FlxG.random.int(2, 4), function(timer:FlxTimer)
					{
						if (FlxG.random.int(0, 4) == 0)
						{
							health = 0;
						}
					}, Std.int(Math.POSITIVE_INFINITY));
				} : {
					powerRanOut = false;

					persistentUpdate = true;
					persistentDraw = true;
					
					camHUD.alpha = 1;
					vocals.volume = 1;
					FlxG.sound.music.volume = 0.8;
					sixAM();
				}
			}
			if (time != null)
			{
				var curTime = Std.int(Math.min(Math.floor(FlxG.sound.music.time / 1000 / (((Conductor.stepCrochet / 1000) * 1088) / times.length - 1)), times.length));
				time.text = times[curTime] + ' AM';
			}
			if ((FlxG.mouse.overlaps(doorButton) && (FlxG.mouse.justPressed || controls.KEY5) && !doorChanging) || 
				(botPlay && !doorChanging && dad.curCharacter == 'nofriend' && (doorClosed ? dad.animation.curAnim.name != 'attack' : dad.animation.curAnim.name == 'attack')))
			{
				changeDoorState(!doorClosed);
			}
			if (dad.curCharacter == 'nofriend' && dad.animation.curAnim.name == 'attack' && dad.animation.curAnim.finished)
			{
				doorClosed ? {
					var slam = new FlxSound().loadEmbedded(Paths.sound('fiveNights/slam'));
					slam.play();
					dad.playAnim('fail');
					dad.animation.finishCallback = function(animation:String)
					{
						new FlxTimer().start(1.25, function(timer:FlxTimer)
						{
							dad.canDance = true;
							dad.canSing = true;
							dad.dance();
						});
					};
					powerLeft -= FlxG.random.int(2, 4);
				} : {
					health = 0;
				}
			}
		}
		if (baldi != null)
		{
			if (FlxG.mouse.overlaps(baldi) && FlxG.mouse.justPressed)
			{
				isStoryMode = false;
				storyPlaylist = [];
				FlxG.switchState(new MathGameState());
			}
		}
		if (redPortal != null)
		{
			if (FlxG.mouse.overlaps(redPortal) && FlxG.mouse.justPressed)
			{
		 	   FlxG.switchState(new TerminalCheatingState([
			 	new TerminalText(0, [['Warning: ', 1], ['Inteference with an undisclosed varible detected', 1]]),
		  	 	new TerminalText(200, [['Load unfairness.json', 0.5]]),
		  	 	new TerminalText(0, [['ERROR: File is corrupted trying to load an alternative...', 3]]),
		  	 	new TerminalText(0, [['Warning: ', 1],  ['An alternative file has been found.', 2]]),
				new TerminalText(200, [['Load cozen.json', 0.5]]),
				], function()
				{
					isStoryMode = false;
					storyPlaylist = [];
						
					shakeCam = false;
					#if SHADERS_ENABLED
					screenshader.Enabled = false;
					#end

					PlayState.SONG = Song.loadFromJson("cozen"); // you dun fucked up again
					PlayState.storyWeek = 15;
					FlxG.save.data.cozenFound = true;
					FlxG.switchState(new PlayState());
				}));
				return;
			}
		}
		
		if (hat != null)
			{
				if (FlxG.mouse.overlaps(hat) && FlxG.mouse.justPressed)
				{
					PlayState.SONG = Song.loadFromJson('electric-cockaldoodledoo');
					PlayState.storyWeek = 18;
		
					FlxG.save.data.electricCockaldoodledooUnlocked = true;
					FlxG.save.flush();
		
					FlxG.switchState(new PlayState());
				}
			}
		
		var toy = -100 + -Math.sin((curStep / 9.5) * 2) * 30 * 5;
		var tox = -330 -Math.cos((curStep / 9.5)) * 100;

		//welcome to 3d sinning avenue
      if (stageCheck == 'exbungo-land') {
			place.y -= (Math.sin(elapsedtime) * 0.4);
		}
		if (dad.curCharacter == 'recurser')
		{
			toy = 100 + -Math.sin((elapsedtime) * 2) * 300;
			tox = -400 - Math.cos((elapsedtime)) * 200;

			dad.x += (tox - dad.x);
			dad.y += (toy - dad.y);
		}

		if(funnyFloatyBoys.contains(dad.curCharacter.toLowerCase()) && canFloat)
		{
			if (dad.curCharacter.toLowerCase() == "expunged")
			{
				// mentally insane movement
				dad.x += (tox - dad.x) / 12;
				dad.y += (toy - dad.y) / 12;
			}
			else
			{
				dad.y += (Math.sin(elapsedtime) * 0.2);
			}
		}
		if(funnyFloatyBoys.contains(boyfriend.curCharacter.toLowerCase()) && canFloat)
		{
			boyfriend.y += (Math.sin(elapsedtime) * 0.2);
		}
		/*if(funnyFloatyBoys.contains(dadmirror.curCharacter.toLowerCase()))
		{
			dadmirror.y += (Math.sin(elapsedtime) * 0.6);
		}*/

		if(funnyFloatyBoys.contains(gf.curCharacter.toLowerCase()) && canFloat)
		{
			gf.y += (Math.sin(elapsedtime) * 0.2);
		}

		noteWidth = 156 * Note.scales[mania];

		if (modchartoption) {
			if ((SONG.song.toLowerCase() == 'cheating' || SONG.song.toLowerCase() == 'rigged' || localFunny == CharacterFunnyEffect.Dave) && !inCutscene) // fuck you
			{
				var num:Float = 1.5;
				if (mania == 2) num = 1.4;
				if (mania == 3) num = 1.35;
				if (mania == 4) num = 1.3;
				playerStrums.forEach(function(spr:StrumNote)                                               
				{
					spr.x += Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
					spr.x -= Math.sin(elapsedtime) * num;
				});
				dadStrums.forEach(function(spr:StrumNote)
				{
					spr.x -= Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
					spr.x += Math.sin(elapsedtime) * num;
				});
			}
			if (SONG.song.toLowerCase() == 'unfairness' && !inCutscene) // fuck you x2
			{
				var num:Float = 1;
				if (mania == 2) num = 1.5;
				if (mania == 3) num = 1.75;
				if (mania == 4) num = 2.25;
				playerStrums.forEach(function(spr:StrumNote)
				{
					spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime + (spr.ID / num))) * 300);
					spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos((elapsedtime + (spr.ID / num))) * 300);
				});
				dadStrums.forEach(function(spr:StrumNote)
				{
					spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime + (spr.ID)) * 2) * 300);
					spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos((elapsedtime + (spr.ID)) * 2) * 300);
				});
			}
			if (!inCutscene)
			{
				if (localFunny == CharacterFunnyEffect.Recurser)
				{
					playerStrums.forEach(function(spr:StrumNote)
					{
						spr.y = spr.baseY + ((Math.sin(elapsedtime + spr.ID)) * (noteWidth * 0.75));
					});
					dadStrums.forEach(function(spr:StrumNote)
					{
						spr.y = spr.baseY + ((Math.sin(elapsedtime + (spr.ID + 4))) * (noteWidth * 0.75));
					});
				}
			}
	
			if (SONG.song.toLowerCase() == 'exploitation' && !inCutscene && mcStarted) // fuck you
			{
				switch (modchart)
				{
					case ExploitationModchartType.None:
	
					case ExploitationModchartType.Jitterwave:
						playerStrums.forEach(function(spr:StrumNote)
						{
							if (mania == 5) {
								if (spr.ID == 1 || spr.ID == 5 || spr.ID == 9)
								{
									spr.x = playerStrums.members[spr.ID + 1].baseX;
								}
								else if (spr.ID == 2 || spr.ID == 6 || spr.ID == 10)
								{
									spr.x = playerStrums.members[spr.ID - 1].baseX;
								}
								else
								{
									spr.x = spr.baseX;
								}
							} else {
								if (spr.ID == 1)
								{
									spr.x = playerStrums.members[2].baseX;
								}
								else if (spr.ID == 2)
								{
									spr.x = playerStrums.members[1].baseX;
								}
								else
								{
									spr.x = spr.baseX;
								}
							}
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + ((Math.sin((elapsedtime + spr.ID) * (((curBeat % 6) + 1) * 0.6))) * 140);
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							if (mania == 5) {
								if (spr.ID == 1 || spr.ID == 5 || spr.ID == 9)
								{
									spr.x = dadStrums.members[spr.ID + 1].baseX;
								}
								else if (spr.ID == 2 || spr.ID == 6 || spr.ID == 10)
								{
									spr.x = dadStrums.members[spr.ID - 1].baseX;
								}
								else
								{
									spr.x = spr.baseX;
								}
							} else {
								if (spr.ID == 1)
								{
									spr.x = dadStrums.members[2].baseX;
								}
								else if (spr.ID == 2)
								{
									spr.x = dadStrums.members[1].baseX;
								}
								else
								{
									spr.x = spr.baseX;
								}
							}
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + ((Math.sin((elapsedtime + spr.ID) * (((curBeat % 6) + 1) * 0.6))) * 140);
						});
						
					case ExploitationModchartType.Cheating:
						playerStrums.forEach(function(spr:StrumNote)
						{
							spr.x += (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * ((spr.ID % 3) == 0 ? 1 : -1);
							spr.x -= (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * (((spr.ID / 3) + 1.2) * (mania == 5 ? 0.1 : 1));
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.x -= (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * ((spr.ID % 3) == 0 ? 1 : -1);
							spr.x += (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * (((spr.ID / 3) + 1.2) * (mania == 5 ? 0.1 : 1));
						});
	
					case ExploitationModchartType.Sex: 
						playerStrums.forEach(function(spr:StrumNote)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2));
							spr.y = ((FlxG.height / 2) - (noteWidth / 2));
							if (mania == 5) {
								if (spr.ID == 0)
								{
									spr.x -= noteWidth * 6.5;
								}
								if (spr.ID == 2)
								{
									spr.x -= noteWidth * 5.3;
									spr.y += noteWidth * 0.6;
								}
								if (spr.ID == 1)
								{
									spr.x -= noteWidth * 4.1;
									spr.y += noteWidth * 1.2;
								}
								if (spr.ID == 3)
								{
									spr.x -= noteWidth * 2.9;
									spr.y += noteWidth * 1.7;
								}
								if (spr.ID == 4)
								{
									spr.x -= noteWidth * 1.7;
									spr.y += noteWidth * 1.9;
								}
								if (spr.ID == 6)
								{
									spr.x -= noteWidth * 0.5;
									spr.y += noteWidth * 2;
								}
								if (spr.ID == 5)
								{
									spr.x += noteWidth * 0.5;
									spr.y += noteWidth * 2;
								}
								if (spr.ID == 7)
								{
									spr.x += noteWidth * 1.7;
									spr.y += noteWidth * 1.9;
								}
								if (spr.ID == 8)
								{
									spr.x += noteWidth * 2.9;
									spr.y += noteWidth * 1.7;
								}
								if (spr.ID == 10)
								{
									spr.x += noteWidth * 4.1;
									spr.y += noteWidth * 1.2;
								}
								if (spr.ID == 9)
								{
									spr.x += noteWidth * 5.3;
									spr.y += noteWidth * 0.6;
								}
								if (spr.ID == 11)
								{
									spr.x += noteWidth * 6.5;
								}
							} else {
								if (spr.ID == 0)
								{
									spr.x -= noteWidth * 2.5;
								}
								if (spr.ID == 1)
								{
									spr.x += noteWidth * 0.5;
									spr.y += noteWidth;
								}
								if (spr.ID == 2)
								{
									spr.x -= noteWidth * 0.5;
									spr.y += noteWidth;
								}
								if (spr.ID == 3)
								{
									spr.x += noteWidth * 2.5;
								}
							}
							spr.x += Math.sin(elapsedtime * (spr.ID + 1)) * (30 * (mania == 5 ? 0.5 : 1));
							spr.y += Math.cos(elapsedtime * (spr.ID + 1)) * (30 * (mania == 5 ? 0.5 : 1));
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2));
							spr.y = ((FlxG.height / 2) - (noteWidth / 2));
							spr.x += (noteWidth * (Main.keyAmmo[mania] - 1 - spr.ID)) - ((Main.keyAmmo[mania] / 2) * noteWidth) + (noteWidth * 0.5);
							spr.x += Math.sin(elapsedtime * (spr.ID + 1)) * (-30 * (mania == 5 ? 0.5 : 1));
							spr.y += Math.cos(elapsedtime * (spr.ID + 1)) * (-30 * (mania == 5 ? 0.5 : 1));
						});
					case ExploitationModchartType.Unfairness: //unfairnesses mod chart with a few changes to keep it interesting
						playerStrums.forEach(function(spr:StrumNote)
						{
							//0.62 is a speed modifier. its there simply because i thought the og modchart was a bit too hard.
							spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin(((elapsedtime + (spr.ID * 2 / (mania == 5 ? 3 : 1)))) * 0.62) * 250);
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos(((elapsedtime + (spr.ID * 0.5 / (mania == 5 ? 3 : 1)))) * 0.62) * 250);
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin(((elapsedtime + (spr.ID * 0.5)) * 2) * 0.62) * 250);
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos(((elapsedtime + (spr.ID * 2)) * 2) * 0.62) * 250);
						});
	
					case ExploitationModchartType.PingPong:
						var xx = (FlxG.width / 2.4) + (Math.sin(elapsedtime * 1.2) * 400);
						var yy = (FlxG.height / 2) + (Math.sin(elapsedtime * 1.5) * 200) - 50;
						var xx2 = (FlxG.width / 2.4) + (Math.cos(elapsedtime) * 400);
						var yy2 = (FlxG.height / 2) + (Math.cos(elapsedtime * 1.4) * 200) - 50;
						playerStrums.forEach(function(spr:StrumNote)
						{
							var bol = spr.ID == 0 || spr.ID == 2;
							var bol2 = spr.ID == 1 || spr.ID == 3;
							if (mania == 5) bol = spr.ID == 0 || spr.ID == 2 || spr.ID == 4 || spr.ID == 6 || spr.ID == 8 || spr.ID == 10;
							if (mania == 5) bol2 = spr.ID == 1 || spr.ID == 3 || spr.ID == 5 || spr.ID == 7 || spr.ID == 9 || spr.ID == 11;
							spr.x = (xx + (noteWidth / 2)) - (bol ? noteWidth : bol2 ? -noteWidth : 0);
							spr.y = (yy + (noteWidth / 2)) - (spr.ID <= (Main.keyAmmo[mania] / 2 - 1) ? 0 : noteWidth);
							spr.x += Math.sin((elapsedtime + (spr.ID * 3)) / 3) * noteWidth;
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							var bol = spr.ID == 0 || spr.ID == 2;
							var bol2 = spr.ID == 1 || spr.ID == 3;
							if (mania == 5) bol = spr.ID == 0 || spr.ID == 2 || spr.ID == 4 || spr.ID == 6 || spr.ID == 8 || spr.ID == 10;
							if (mania == 5) bol2 = spr.ID == 1 || spr.ID == 3 || spr.ID == 5 || spr.ID == 7 || spr.ID == 9 || spr.ID == 11;
							spr.x = (xx2 + (noteWidth / 2)) - (bol ? noteWidth : bol2 ? -noteWidth : 0);
							spr.y = (yy2 + (noteWidth / 2)) - (spr.ID <= (Main.keyAmmo[mania] / 2 - 1) ? 0 : noteWidth);
							spr.x += Math.sin((elapsedtime + (spr.ID * (mania == 5 ? 1 : 3))) / 3) * noteWidth;
	
						});
	
					case ExploitationModchartType.Figure8:
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime * 0.3) + spr.ID + 1) * (FlxG.width * 0.4));
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.sin(((elapsedtime * 0.3) + spr.ID) * 3) * (FlxG.height * 0.2));
						});
						dadStrums.forEach(function(spr:FlxSprite)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime * 0.3) + spr.ID + 1.5) * (FlxG.width * 0.4));
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.sin((((elapsedtime * 0.3) + spr.ID) * -3) + 0.5) * (FlxG.height * 0.2));
						});
					case ExploitationModchartType.ScrambledNotes:
						playerStrums.forEach(function(spr:StrumNote)
						{
							spr.x = (FlxG.width / 2) + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * ((mania == 5 ? 20 : 60) * (spr.ID + 1));
							spr.x += Math.sin(elapsedtime - 1) * 40;
							spr.y = (FlxG.height / 2) + (Math.sin(elapsedtime - 69.2) * ((spr.ID % 3) == 0 ? 1 : -1)) * ((mania == 5 ? 25 : 67) * (spr.ID + 1)) - 15;
							spr.y += Math.cos(elapsedtime - 1) * 40;
							spr.x -= 80;
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.x = (FlxG.width / 2) + (Math.cos(elapsedtime - 1) * ((spr.ID % 2) == 0 ? -1 : 1)) * ((mania == 5 ? 20 : 60) * (spr.ID + 1));
							spr.x += Math.sin(elapsedtime - 1) * 40;
							spr.y = (FlxG.height / 2) + (Math.sin(elapsedtime - 63.4) * ((spr.ID % 3) == 0 ? -1 : 1)) * ((mania == 5 ? 25 : 67) * (spr.ID + 1)) - 15;
							spr.y += Math.cos(elapsedtime - 1) * 40;
							spr.x -= 80;
						});
	
					case ExploitationModchartType.Cyclone:
						playerStrums.forEach(function(spr:StrumNote)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
						});
						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.cos((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
							spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.sin((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
						});
				}
			}

			if (SONG.song.toLowerCase() == 'importumania' && !inCutscene && mcStarted) // fuck you
			{
					switch (modchart)
					{
						case ExploitationModchartType.None:
		
						case ExploitationModchartType.Jitterwave:
							playerStrums.forEach(function(spr:StrumNote)
							{
								if (mania == 5) {
									if (spr.ID == 1 || spr.ID == 5 || spr.ID == 9)
									{
										spr.x = playerStrums.members[spr.ID + 1].baseX;
									}
									else if (spr.ID == 2 || spr.ID == 6 || spr.ID == 10)
									{
										spr.x = playerStrums.members[spr.ID - 1].baseX;
									}
									else
									{
										spr.x = spr.baseX;
									}
								} else {
									if (spr.ID == 1)
									{
										spr.x = playerStrums.members[2].baseX;
									}
									else if (spr.ID == 2)
									{
										spr.x = playerStrums.members[1].baseX;
									}
									else
									{
										spr.x = spr.baseX;
									}
								}
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + ((Math.sin((elapsedtime + spr.ID) * (((curBeat % 6) + 1) * 0.6))) * 140);
							});
							dadStrums.forEach(function(spr:StrumNote)
							{
								if (mania == 5) {
									if (spr.ID == 1 || spr.ID == 5 || spr.ID == 9)
									{
										spr.x = dadStrums.members[spr.ID + 1].baseX;
									}
									else if (spr.ID == 2 || spr.ID == 6 || spr.ID == 10)
									{
										spr.x = dadStrums.members[spr.ID - 1].baseX;
									}
									else
									{
										spr.x = spr.baseX;
									}
								} else {
									if (spr.ID == 1)
									{
										spr.x = dadStrums.members[2].baseX;
									}
									else if (spr.ID == 2)
									{
										spr.x = dadStrums.members[1].baseX;
									}
									else
									{
										spr.x = spr.baseX;
									}
								}
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + ((Math.sin((elapsedtime + spr.ID) * (((curBeat % 6) + 1) * 0.6))) * 140);
							});
							
						case ExploitationModchartType.Cheating:
							playerStrums.forEach(function(spr:StrumNote)
							{
								spr.x -= (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * ((spr.ID % 3) == 0 ? 1 : -1);
								spr.x += (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * (((spr.ID / 3) + 1.2) * (mania == 5 ? 0.1 : 1));
							});
							dadStrums.forEach(function(spr:StrumNote)
							{			
								spr.x += (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * ((spr.ID % 3) == 0 ? 1 : -1);
								spr.x -= (spr.ID == 1 ? 0.5 : 1) * Math.sin(elapsedtime) * (((spr.ID / 3) + 1.2) * (mania == 5 ? 0.1 : 1));												
								
							});
		
						case ExploitationModchartType.Sex: 
							playerStrums.forEach(function(spr:StrumNote)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2));
								spr.y = ((FlxG.height / 2) - (noteWidth / 2));
								if (mania == 5) {
									if (spr.ID == 0)
									{
										spr.x -= noteWidth * 6.5;
									}
									if (spr.ID == 2)
									{
										spr.x -= noteWidth * 5.3;
										spr.y += noteWidth * 0.6;
									}
									if (spr.ID == 1)
									{
										spr.x -= noteWidth * 4.1;
										spr.y += noteWidth * 1.2;
									}
									if (spr.ID == 3)
									{
										spr.x -= noteWidth * 2.9;
										spr.y += noteWidth * 1.7;
									}
									if (spr.ID == 4)
									{
										spr.x -= noteWidth * 1.7;
										spr.y += noteWidth * 1.9;
									}
									if (spr.ID == 6)
									{
										spr.x -= noteWidth * 0.5;
										spr.y += noteWidth * 2;
									}
									if (spr.ID == 5)
									{
										spr.x += noteWidth * 0.5;
										spr.y += noteWidth * 2;
									}
									if (spr.ID == 7)
									{
										spr.x += noteWidth * 1.7;
										spr.y += noteWidth * 1.9;
									}
									if (spr.ID == 8)
									{
										spr.x += noteWidth * 2.9;
										spr.y += noteWidth * 1.7;
									}
									if (spr.ID == 10)
									{
										spr.x += noteWidth * 4.1;
										spr.y += noteWidth * 1.2;
									}
									if (spr.ID == 9)
									{
										spr.x += noteWidth * 5.3;
										spr.y += noteWidth * 0.6;
									}
									if (spr.ID == 11)
									{
										spr.x += noteWidth * 6.5;
									}
								} else {
									if (spr.ID == 0)
									{
										spr.x -= noteWidth * 2.5;
									}
									if (spr.ID == 1)
									{
										spr.x += noteWidth * 0.5;
										spr.y += noteWidth;
									}
									if (spr.ID == 2)
									{
										spr.x -= noteWidth * 0.5;
										spr.y += noteWidth;
									}
									if (spr.ID == 3)
									{
										spr.x += noteWidth * 2.5;
									}
								}
								spr.x += Math.sin(elapsedtime * (spr.ID + 1)) * (30 * (mania == 5 ? 0.5 : 1));
								spr.y += Math.cos(elapsedtime * (spr.ID + 1)) * (30 * (mania == 5 ? 0.5 : 1));
							});
							dadStrums.forEach(function(spr:StrumNote)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2));
								spr.y = ((FlxG.height / 2) - (noteWidth / 2));
								spr.x += (noteWidth * (Main.keyAmmo[mania] - 1 - spr.ID)) - ((Main.keyAmmo[mania] / 2) * noteWidth) + (noteWidth * 0.5);
								spr.x += Math.sin(elapsedtime * (spr.ID + 1)) * (-30 * (mania == 5 ? 0.5 : 1));
								spr.y += Math.cos(elapsedtime * (spr.ID + 1)) * (-30 * (mania == 5 ? 0.5 : 1));
							});
						case ExploitationModchartType.Unfairness: //unfairnesses mod chart with a few changes to keep it interesting
						    var num:Float = 1;
							if (mania == 2) num = 1.5;
							if (mania == 3) num = 1.75;
							if (mania == 4) num = 2.25;
							playerStrums.forEach(function(spr:StrumNote)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime + (spr.ID / num))) * 300);
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos((elapsedtime + (spr.ID / num))) * 300);
							});
							dadStrums.forEach(function(spr:StrumNote)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime + (spr.ID)) * 2) * 300);
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos((elapsedtime + (spr.ID)) * 2) * 300);
							});		
						case ExploitationModchartType.PingPong:
							var xx = (FlxG.width / 2.4) + (Math.sin(elapsedtime * 1.2) * 400);
							var yy = (FlxG.height / 2) + (Math.sin(elapsedtime * 1.5) * 200) - 50;
							var xx2 = (FlxG.width / 2.4) + (Math.cos(elapsedtime) * 400);
							var yy2 = (FlxG.height / 2) + (Math.cos(elapsedtime * 1.4) * 200) - 50;
							playerStrums.forEach(function(spr:StrumNote)
							{
								var bol = spr.ID == 0 || spr.ID == 2;
								var bol2 = spr.ID == 1 || spr.ID == 3;
								if (mania == 5) bol = spr.ID == 0 || spr.ID == 2 || spr.ID == 4 || spr.ID == 6 || spr.ID == 8 || spr.ID == 10;
								if (mania == 5) bol2 = spr.ID == 1 || spr.ID == 3 || spr.ID == 5 || spr.ID == 7 || spr.ID == 9 || spr.ID == 11;
								spr.x = (xx + (noteWidth / 2)) - (bol ? noteWidth : bol2 ? -noteWidth : 0);
								spr.y = (yy + (noteWidth / 2)) - (spr.ID <= (Main.keyAmmo[mania] / 2 - 1) ? 0 : noteWidth);
								spr.x += Math.sin((elapsedtime + (spr.ID * 3)) / 3) * noteWidth;
							});
							dadStrums.forEach(function(spr:StrumNote)
							{
								var bol = spr.ID == 0 || spr.ID == 2;
								var bol2 = spr.ID == 1 || spr.ID == 3;
								if (mania == 5) bol = spr.ID == 0 || spr.ID == 2 || spr.ID == 4 || spr.ID == 6 || spr.ID == 8 || spr.ID == 10;
								if (mania == 5) bol2 = spr.ID == 1 || spr.ID == 3 || spr.ID == 5 || spr.ID == 7 || spr.ID == 9 || spr.ID == 11;
								spr.x = (xx2 + (noteWidth / 2)) - (bol ? noteWidth : bol2 ? -noteWidth : 0);
								spr.y = (yy2 + (noteWidth / 2)) - (spr.ID <= (Main.keyAmmo[mania] / 2 - 1) ? 0 : noteWidth);
								spr.x += Math.sin((elapsedtime + (spr.ID * (mania == 5 ? 1 : 3))) / 3) * noteWidth;
		
							});
		
						case ExploitationModchartType.Figure8:
							playerStrums.forEach(function(spr:FlxSprite)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime * 0.3) + spr.ID + 1) * (FlxG.width * 0.4));
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.sin(((elapsedtime * 0.3) + spr.ID) * 3) * (FlxG.height * 0.2));
							});
							dadStrums.forEach(function(spr:FlxSprite)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((elapsedtime * 0.3) + spr.ID + 1.5) * (FlxG.width * 0.4));
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.sin((((elapsedtime * 0.3) + spr.ID) * -3) + 0.5) * (FlxG.height * 0.2));
							});
						case ExploitationModchartType.ScrambledNotes:
							playerStrums.forEach(function(spr:StrumNote)
							{
								spr.x = (FlxG.width / 2) + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * ((mania == 5 ? 20 : 60) * (spr.ID + 1));
								spr.x += Math.sin(elapsedtime - 1) * 40;
								spr.y = (FlxG.height / 2) + (Math.sin(elapsedtime - 69.2) * ((spr.ID % 3) == 0 ? 1 : -1)) * ((mania == 5 ? 25 : 67) * (spr.ID + 1)) - 15;
								spr.y += Math.cos(elapsedtime - 1) * 40;
								spr.x -= 80;
							});
							dadStrums.forEach(function(spr:StrumNote)
							{
								spr.x = (FlxG.width / 2) + (Math.cos(elapsedtime - 1) * ((spr.ID % 2) == 0 ? -1 : 1)) * ((mania == 5 ? 20 : 60) * (spr.ID + 1));
								spr.x += Math.sin(elapsedtime - 1) * 40;
								spr.y = (FlxG.height / 2) + (Math.sin(elapsedtime - 63.4) * ((spr.ID % 3) == 0 ? -1 : 1)) * ((mania == 5 ? 25 : 67) * (spr.ID + 1)) - 15;
								spr.y += Math.cos(elapsedtime - 1) * 40;
								spr.x -= 80;
							});
		
						case ExploitationModchartType.Cyclone:
							playerStrums.forEach(function(spr:StrumNote)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.sin((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.cos((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
							});
							dadStrums.forEach(function(spr:StrumNote)
							{
								spr.x = ((FlxG.width / 2) - (noteWidth / 2)) + (Math.cos((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
								spr.y = ((FlxG.height / 2) - (noteWidth / 2)) + (Math.sin((spr.ID + 1) * (elapsedtime * 0.15)) * ((mania == 5 ? 25 : 65) * (spr.ID + 1)));
							});
				}
			}
		}
		// no more 3d sinning avenue
		if (daveFlying)
		{
			dad.y -= elapsed * 50;
			dad.angle -= elapsed * 6;
		}
		if (tweenList != null && tweenList.length != 0)
		{
			for (tween in tweenList)
			{
				if (tween.active && !tween.finished && !activateSunTweens)
					tween.percent = FlxG.sound.music.time / tweenTime;
			}
		}
        
		#if SHADERS_ENABLED
		FlxG.camera.setFilters([new ShaderFilter(screenshader.shader)]); // this is very stupid but doesn't effect memory all that much so
		#end
		if (shakeCam && eyesoreson)
		{
			// var shad = cast(FlxG.camera.screen.shader,Shaders.PulseShader);
			FlxG.camera.shake(0.010, 0.010);
		}

		#if SHADERS_ENABLED
		screenshader.shader.uTime.value[0] += elapsed;
		lazychartshader.shader.uTime.value[0] += elapsed;
		if (blockedShader != null)
		{
			blockedShader.update(elapsed);
		}
		if (shakeCam && eyesoreson)
		{
			screenshader.shader.uampmul.value[0] = 1;
		}
		else
		{
			screenshader.shader.uampmul.value[0] -= (elapsed / 2);
		}
		screenshader.Enabled = shakeCam && eyesoreson;
		#end

		super.update(elapsed);

		switch (SONG.song.toLowerCase())
		{
			case 'overdrive':
				scoreTxt.text = "score: " + Std.string(songScore);
			case 'exploitation':
				if(ratingString == '?') {
					extraTxt.text =
					LanguageManager.getTextString('play_opponentnotecount') + opponentnotecount;
					scoreTxt.text = 
					"N9S: " + nps + " (" + maxNPS + ") ~ " + 
					"Scor3: " + (songScore * FlxG.random.int(1,9)) + 
					" ~ M1ss3s: " + (misses * FlxG.random.int(1,9)) + 
					" ~ Accuracy: " + (truncateFloat(accuracy, 2) * FlxG.random.int(1,9)) + "% ~ " +
					ratingString;
					healthTxt.text = 
					Math.floor(health * 500) / 10 + "%";
				} else {
					extraTxt.text =
					LanguageManager.getTextString('play_opponentnotecount') + opponentnotecount;
					scoreTxt.text = 
					"N9S: " + nps + " (" + maxNPS + ") ~ " + 
					"Scor3: " + (songScore * FlxG.random.int(1,9)) + 
					" ~ M1ss3s: " + (misses * FlxG.random.int(1,9)) + 
					" ~ Accuracy: " + (truncateFloat(accuracy, 2) * FlxG.random.int(1,9)) + "% ~ " +
					'(' + ratingFC + ') ' + ratingString;
					healthTxt.text = 
					Math.floor(health * 500) / 10 + "%";
				}
			default:
				if(ratingString == '?') {
					extraTxt.text =
					LanguageManager.getTextString('play_opponentnotecount') + opponentnotecount;
					scoreTxt.text =
					"NPS: " + nps + " (" + maxNPS + ") ~ " + 
					LanguageManager.getTextString('play_score') + Std.string(songScore) + " ~ " + 
					LanguageManager.getTextString('play_miss') + misses +  " ~ " + 
					LanguageManager.getTextString('play_accuracy') + truncateFloat(accuracy, 2) + "% ~ " +
					ratingString;
					healthTxt.text = 
					Math.floor(health * 500) / 10 + "%";
				} else {
					extraTxt.text =
					LanguageManager.getTextString('play_opponentnotecount') + opponentnotecount;
					scoreTxt.text =
					"NPS: " + nps + " (" + maxNPS + ") ~ " + 
					LanguageManager.getTextString('play_score') + Std.string(songScore) + " ~ " + 
					LanguageManager.getTextString('play_miss') + misses +  " ~ " + 
					LanguageManager.getTextString('play_accuracy') + truncateFloat(accuracy, 2) + "% ~ " +
					'(' + ratingFC + ') ' + ratingString;
					healthTxt.text = 
					Math.floor(health * 500) / 10 + "%";
				}
		}
		if (noMiss)
		{
			scoreTxt.text += " ~ NO MISS!!";
		}

		// 1 - ~0.87
		perlinElapsed.add(elapsed * (1 - Math.sqrt(3)), -elapsed * (1 - Math.sqrt(3)));

		FlxG.camera.targetOffset.set(perlinCamera.noise2d(perlinElapsed.x, perlinElapsed.x) * 7, perlinCamera.noise2d(perlinElapsed.y, perlinElapsed.y) * 7);

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				// gitaroo man easter egg
				FlxG.switchState(new GitarooPause());
			}
			else
			{
				if (SONG.song.toLowerCase() == 'exploitation' && modchartoption) //damn it
				{
					playerStrums.forEach(function(note:StrumNote)
					{
						FlxTween.completeTweensOf(note);
					});
					dadStrums.forEach(function(note:StrumNote)
					{
						FlxTween.completeTweensOf(note);
					});
				}
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			if(FlxTransitionableState.skipNextTransIn)
			{
				Transition.nextCamera = null;
			}
			
			switch (curSong.toLowerCase())
			{
				case 'supernovae':
					FlxG.switchState(new TerminalCheatingState([
						new TerminalText(0, [['Warning: ', 1], ['Chart Editor access detected', 1],]),
						new TerminalText(200, [['run AntiCheat.dll', 0.5]]),
						new TerminalText(0, [['ERROR: File currently being used by another process. Retrying in 3...', 3]]),
						new TerminalText(200, [['File no longer in use, running AntiCheat.dll..', 2]]),
					], function()
					{
						shakeCam = false;
						#if SHADERS_ENABLED
						screenshader.Enabled = false;
						#end

						isStoryMode = false;
						PlayState.SONG = Song.loadFromJson("cheating"); // you dun fucked up
						isStoryMode = false;
						PlayState.storyWeek = 14;
						FlxG.save.data.cheatingFound = true;
						FlxG.switchState(new PlayState());
					}));
					return;
				case 'vs-dave-thanksgiving':
					FlxG.switchState(new TerminalCheatingState([
						new TerminalText(0, [['Warning: ', 1], ['Chart Editor access detected', 1],]),
						new TerminalText(200, [['run AntiCheat.dll', 0.5]]),
						new TerminalText(0, [['ERROR: File currently being used by another process. Retrying in 3...', 3]]),
						new TerminalText(200, [['File no longer in use, running AntiCheat.dll..', 2]]),
					], function()
					{
						shakeCam = false;
						#if SHADERS_ENABLED
						screenshader.Enabled = false;
						#end

						isStoryMode = false;
						PlayState.SONG = Song.loadFromJson("rigged"); // you dun fucked up again
						isStoryMode = false;
						PlayState.storyWeek = 14;
						FlxG.save.data.riggedFound = true;
						FlxG.switchState(new PlayState());
					}));
					return;
				case 'cheating' | 'rigged' :
					FlxG.switchState(new TerminalCheatingState([
						new TerminalText(0, [['Warning: ', 1], ['Chart Editor access detected', 1],]),
						new TerminalText(200, [['run AntiCheat.dll', 3]]),
					], function()
					{
						isStoryMode = false;
						storyPlaylist = [];
						
						shakeCam = false;
						#if SHADERS_ENABLED
						screenshader.Enabled = false;
						#end

						PlayState.SONG = Song.loadFromJson("unfairness"); // you dun fucked up again
						PlayState.storyWeek = 15;
						FlxG.save.data.unfairnessFound = true;
						FlxG.save.data.oppressionFound = true;
						FlxG.switchState(new PlayState());
					}));
					return;
				case 'unfairness':
					FlxG.switchState(new TerminalCheatingState([
						new TerminalText(0, [
							['bin/plugins/AntiCheat.dll: ', 1],
							['No argument for function "AntiCheatThree"', 1],
						]),
						new TerminalText(100, [['Redirecting to terminal...', 1]])
					], function()
					{
						isStoryMode = false;
						storyPlaylist = [];
						
						shakeCam = false;
						#if SHADERS_ENABLED
						screenshader.Enabled = false;
						#end

						FlxG.switchState(new TerminalState());
					}));
					#if desktop
					DiscordClient.changePresence("I have your IP address", null, null, true);
					#end
					return;
				case 'exploitation' | 'master' | 'importumania' | 'secret-mod-leak' | 'secret':
					health = 0;
				case 'recursed':
					ChartingState.hahaFunnyRecursed();
				case 'glitch':
					isStoryMode = false;
					storyPlaylist = [];
					
					PlayState.SONG = Song.loadFromJson("kabunga"); // lol you loser
					isStoryMode = false;
					FlxG.save.data.exbungoFound = true;
					shakeCam = false;
					#if SHADERS_ENABLED
					screenshader.Enabled = false;
					#end
					FlxG.switchState(new PlayState());
					return;
				case 'kabunga':
					fancyOpenURL("https://benjaminpants.github.io/muko_firefox/index.html"); //banger game
					System.exit(0);
				case 'vs-dave-rap':
					PlayState.SONG = Song.loadFromJson("vs-dave-rap-two");
					FlxG.save.data.vsDaveRapTwoFound = true;
					shakeCam = false;
					#if SHADERS_ENABLED
					screenshader.Enabled = false;
					#end
					FlxG.switchState(new PlayState());
					return;
				default:
					#if SHADERS_ENABLED
					resetShader();
					#end
					FlxG.switchState(new ChartingState());
					#if desktop
					DiscordClient.changePresence("Chart Editor", null, null, true);
					#end
			}
		}

		#if debug
		if (FlxG.keys.justPressed.THREE)
		{
			if(FlxTransitionableState.skipNextTransIn)
			{
				Transition.nextCamera = null;
			}
			
			#if SHADERS_ENABLED
			resetShader();
			#end
			FlxG.switchState(new ChartingState());
			#if desktop
			DiscordClient.changePresence("Chart Editor", null, null, true);
			#end
		}
		#end

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		var thingy = 0.88; //(144 / Main.fps.currentFPS) * 0.88;
		//still gotta make this fps consistent crap

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, thingy)),Std.int(FlxMath.lerp(150, iconP1.height, thingy)));
		iconP1.updateHitbox();

		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, thingy)),Std.int(FlxMath.lerp(150, iconP2.height, thingy)));
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		if (inFiveNights)
		{
			iconP1.x = (healthBar.x + healthBar.width) - (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) + iconOffset);
			iconP2.x = (healthBar.x + healthBar.width) - (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);
		}
		else
		{
			iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
			iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);
		}

		if (health > 2)
			health = 2;

		if (SONG.song.toLowerCase() != "five-nights")
		{
			if (healthBar.percent < 20)
				iconP1.changeState('losing');
			else
				iconP1.changeState('normal');

			if (healthBar.percent > 80)
				iconP2.changeState('losing');
			else
				iconP2.changeState('normal');
		}
		else
		{
			if (healthBar.percent < 20)
				iconP2.changeState('losing');
			else
				iconP2.changeState('normal');

			if (healthBar.percent > 80)
				iconP1.changeState('losing');
			else
				iconP1.changeState('normal');
		}

		if(healthBar.percent < 30)
			FlxTween.tween(badLoseVin, {alpha:0.75}, 1, {ease: FlxEase.linear});
		else
			FlxTween.tween(badLoseVin, {alpha: 0}, 1, {ease: FlxEase.linear});

		#if debug
		if (FlxG.keys.justPressed.FOUR)
		{
			trace('DUMP LOL:\nDAD POSITION: ${dad.getPosition()}\nBOYFRIEND POSITION: ${boyfriend.getPosition()}\nGF POSITION: ${gf.getPosition()}\nCAMERA POSITION: ${camFollow.getPosition()}');
		}
		/*if (FlxG.keys.justPressed.FIVE)
		{
			FlxG.switchState(new CharacterDebug(dad.curCharacter));
		}
		if (FlxG.keys.justPressed.SEMICOLON)
		{
			FlxG.switchState(new CharacterDebug(boyfriend.curCharacter));
		}
		if (FlxG.keys.justPressed.COMMA)
		{
			FlxG.switchState(new CharacterDebug(gf.curCharacter));
		}
		if (FlxG.keys.justPressed.EIGHT)
			FlxG.switchState(new AnimationDebug(dad.curCharacter));
		if (FlxG.keys.justPressed.SIX)
			FlxG.switchState(new AnimationDebug(boyfriend.curCharacter));*/
		if (FlxG.keys.justPressed.TWO) //Go 10 seconds into the future :O
		{
			FlxG.sound.music.pause();
			vocals.pause();
			boyfriend.stunned = true;
			Conductor.songPosition += 10000;
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.strumTime + 800 < Conductor.songPosition) {
					daNote.active = false;
					daNote.visible = false;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			});
			for (i in 0...unspawnNotes.length)
			{
				var daNote:Note = unspawnNotes[0];
				if (daNote.strumTime + 800 >= Conductor.songPosition)
				{
					break;
				}

				daNote.active = false;
				daNote.visible = false;

				daNote.kill();
				unspawnNotes.splice(unspawnNotes.indexOf(daNote), 1);
				daNote.destroy();
			}

			FlxG.sound.music.time = Conductor.songPosition;
			FlxG.sound.music.play();

			vocals.time = Conductor.songPosition;
			vocals.play();
			boyfriend.stunned = false;
		}
		/*if (FlxG.keys.justPressed.THREE)
			FlxG.switchState(new AnimationDebug(gf.curCharacter));*/
		#end
	
		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
				{
					startSong();
				}
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}
		if (crazyZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (health <= 0 && !botPlay)
		{
			if(!perfectMode)
			{
				boyfriend.stunned = true;

				persistentUpdate = false;
				persistentDraw = false;
				paused = true;

				deathCounter++;
	
				vocals.stop();
				FlxG.sound.music.stop();
				
				#if SHADERS_ENABLED
				screenshader.shader.uampmul.value[0] = 0;
				screenshader.Enabled = false;
				#end
			}

			if (!shakeCam)
			{
				if(!perfectMode)
				{
					gameOver();
				}
			}
			else
			{
				CharacterSelectState.unlockCharacter('bambi-3d');
				CharacterSelectState.unlockCharacter('bambi-3d-scrapped');
				if (isStoryMode)
				{
					switch (SONG.song.toLowerCase())
					{
						case 'blocked' | 'corn-theft' | 'maze':
							FlxG.openURL("https://www.youtube.com/watch?v=eTJOdgDzD64");
							System.exit(0);
						default:
							if (shakeCam)
							{
								CharacterSelectState.unlockCharacter('bambi-3d');
							}
							FlxG.switchState(new EndingState('rtxx_ending', 'badEnding'));
					}
				}
				else
				{
					if (!perfectMode)
					{
						if(shakeCam)
						{
							CharacterSelectState.unlockCharacter('bambi-3d');
						}
						gameOver();
					}
				}
			}

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (unspawnNotes[0] != null)
		{
			var thing:Int = ((SONG.song.toLowerCase() == 'unfairness' || PlayState.SONG.song.toLowerCase() == 'exploitation') && modchartoption ? 20000 : 1500);

			if (unspawnNotes[0].strumTime - Conductor.songPosition < thing)
			{
				var dunceNote:Note = unspawnNotes[0];
				dunceNote.finishedGenerating = true;

				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);

				if (!dunceNote.isSustainNote && dunceNote.noteStyle != 'guitarHero') {
					dunceNote.updateHitbox();
					dunceNote.offset.x = dunceNote.frameWidth / 2;
					dunceNote.offset.y = dunceNote.frameHeight / 2;
			
					dunceNote.offset.x -= noteWidth / 2;
					dunceNote.offset.y -= noteWidth / 2;
				}
			}
		}
		var currentSection = SONG.notes[Math.floor(curStep / 16)];

		if (generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.y > FlxG.height)
				{
					daNote.active = false;
					daNote.visible = false;
				}
				else
				{
					daNote.visible = true;
					daNote.active = true;
				}
				if (daNote.noteStyle == 'recursed' && daNote.isSustainNote) // kinda weird bug...
				{
					daNote.x -= daNote.width / 2;
					daNote.x += noteWidth / 2;
				}
				if (daNote.mustPress && (Conductor.songPosition >= daNote.strumTime) && daNote.health != 2 && daNote.noteStyle == 'phone')
				{
					daNote.health = 2;
					dad.playAnim(dad.animation.getByName("singThrow") == null ? 'singSmash' : 'singThrow', true);
				}
				if (!daNote.mustPress && daNote.wasGoodHit && !daNote.hitByOpponent)
				{
					if (SONG.song != 'Warmup')
						camZooming = true; 

					var altAnim:String = "";
					var healthtolower:Float = 0.02;

					if (currentSection != null)
					{
						if (daNote.noteStyle == 'phone-alt')
						{
							altAnim = '-alt';
						}
						if (currentSection.altAnim)
							if (SONG.song.toLowerCase() != "cheating")
							{
								altAnim = '-alt';
							}
							else
							{
								healthtolower = 0.005;
							}
					}
					if (inFiveNights && !daNote.isSustainNote)
					{
						dadCombo++;
						createScorePopUp(0, 0, true, FlxG.random.int(0,10) == 0 ? "good" : "sick", dadCombo, "3D");
					}

					var noteTypes = guitarSection ? notestuffsGuitar : notestuffs;
					var noteToPlay:String = noteTypes[Math.round(Math.abs(daNote.originalType)) % dadStrumAmount];
					switch (daNote.noteStyle)
					{
						case 'phone':
							dad.playAnim('singSmash', true);
						case 'phone-zardy':
							boyfriend.playAnim('singSmash', true);
						default:
							if (daNote.noteStyle == 'phone-alt') { // I didn't notice bambi's alt animation has only left and right
								if (noteToPlay == 'UP') noteToPlay = 'RIGHT';
								if (noteToPlay == 'DOWN') noteToPlay = 'LEFT';
							}
							if (dad.nativelyPlayable)
							{
								switch (noteToPlay)
								{
									case 'LEFT':
										noteToPlay = 'RIGHT';
									case 'RIGHT':
										noteToPlay = 'LEFT';
								}
							}
							dad.playAnim('sing' + noteToPlay + altAnim, true);
							if (dadmirror != null)
							{
								dadmirror.playAnim('sing' + noteToPlay + altAnim, true);
							}
					}
					cameraMoveOnNote(noteToPlay, 'dad');
					
					dadStrums.forEach(function(sprite:StrumNote)
					{
						if (Math.abs(Math.round(Math.abs(daNote.noteData)) % dadStrumAmount) == sprite.ID)
						{
							if (daNote.noteStyle != 'guitarHero') {
								sprite.playAnim('confirm', true);
								sprite.animation.finishCallback = function(name:String)
								{
									sprite.playAnim('static', true);
								}
							} else {
								sprite.animation.play('confirm', true);
								if (sprite.animation.curAnim.name == 'confirm')
								{
									sprite.centerOffsets();
									sprite.offset.x -= 13;
									sprite.offset.y -= 13;
								}
								else
								{
									sprite.centerOffsets();
								}
								sprite.animation.finishCallback = function(name:String)
								{
									sprite.animation.play('static', true);
									sprite.centerOffsets();
								}
							}
						}
						sprite.pressingKey5 = daNote.noteStyle == 'shape';
					});

					daNote.hitByOpponent = true;
					if (!daNote.isSustainNote) opponentnotecount += 1;

					if (UsingNewCam)
					{
						focusOnDadGlobal = true;
						ZoomCam(true);
					}

					switch (SONG.song.toLowerCase())
					{
						case 'cheating' | 'rigged':
							health -= healthtolower;
						case 'unfairness':
							var healthadj = 3;
							switch (storyDifficulty) {
								case 0: healthadj = 4;
							}
							health -= (healthtolower / healthadj);
						case 'exploitation':
							if (((health + (FlxEase.backInOut(health / 16.5)) - 0.002) >= 0) && !(curBeat >= 320 && curBeat <= 330))
							{
								health += ((FlxEase.backInOut(health / 16.5)) * (curBeat <= 160 ? 0.25 : 1)) - 0.002; //some training wheels cuz rapparep say mod too hard
							}
						case 'mealie':
							if (curBeat >= 464 && curBeat <= 592) {
								health -= (healthtolower / 1.5);
							}
						case 'five-nights':
							if ((health - 0.023) > 0)
							{
								health -= 0.023;
							}
							else
							{
								health = 0.001;
							}
						case 'importumania':
							if (unfairPart){
								var healthadj = 3;
								switch (storyDifficulty) {
									case 0: healthadj = 4;
								}
								health -= (healthtolower / healthadj);
							}

							if (cheatPart){
								health -= healthtolower;
							}

							if (exploPart)
							{
								if (!daNote.isSustainNote){
									if (((health + (FlxEase.backInOut(health / 16.5)) - 0.002) >= 0) && !(curBeat >= 320 && curBeat <= 330))
									{
										health += ((FlxEase.backInOut(health / 16.5)) * (curBeat <= 160 ? 0.25 : 1)) - 0.002; //some training wheels cuz rapparep say mod too hard
									}
								}
							} 								
						default:
							if (FlxG.save.data.healthdrain && health > 0.2)
							{
								if (!daNote.isSustainNote)
									health -= 0.01725;
								else
									health -= 0.003;
								if (health < 0.2)
									health = 0.2;
							}
					}
					// boyfriend.playAnim('hit',true);
					dad.holdTimer = 0;

					if (SONG.needsVoices)
						vocals.volume = 1;

					if (!daNote.isSustainNote) {
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
				}
				if(daNote.mustPress && botPlay) {
					if(daNote.strumTime <= Conductor.songPosition || (daNote.isSustainNote && daNote.canBeHit && daNote.prevNote.wasGoodHit)) {
						goodNoteHit(daNote);
						boyfriend.holdTimer = 0;
					}
				}

				var strumY:Float = 0;
				if (!guitarSection) strumY = playerStrums.members[daNote.noteData].y;
				if(!daNote.mustPress) strumY = dadStrums.members[daNote.noteData].y;
				var swagWidth = 160 * Note.scales[mania];
				var center:Float = strumY + swagWidth / 2;
				if(daNote.isSustainNote && (daNote.mustPress || (!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit)))))
				{
					if (scrollType == 'downscroll')
					{
						if(daNote.y - daNote.scale.y + daNote.height >= center)
						{
							var swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
							swagRect.height = (center - daNote.y) / daNote.scale.y;
							swagRect.y = daNote.frameHeight - swagRect.height;

							daNote.clipRect = swagRect;
						}
						else
							daNote.clipRect = null;
					}
					else if (scrollType == 'upscroll')
					{
						if (daNote.y + daNote.scale.y <= center)
						{
							var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
							swagRect.y = (center - daNote.y) / daNote.scale.y;
							swagRect.height -= swagRect.y;

							daNote.clipRect = swagRect;
						}
						else
							daNote.clipRect = null;
					}
				}

				if (daNote.MyStrum != null)
				{
					daNote.y = yFromNoteStrumTime(daNote, daNote.MyStrum, scrollType == 'downscroll');
				}
				else
				{
					daNote.y = yFromNoteStrumTime(daNote, strumLine, scrollType == 'downscroll');
				}
				// WIP interpolation shit? Need to fix the pause issue
				// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
				var noteSpeed = (daNote.LocalScrollSpeed == 0 ? 1 : daNote.LocalScrollSpeed);
				
				if (daNote.wasGoodHit && daNote.isSustainNote && Conductor.songPosition >= (daNote.strumTime + daNote.height + 10))
				{
					destroyNote(daNote);
				}
				if (!daNote.wasGoodHit && daNote.mustPress && daNote.finishedGenerating && Conductor.songPosition >= daNote.strumTime + (350 / (0.45 * FlxMath.roundDecimal(SONG.speed * noteSpeed, 2))))
				{
					if (!botPlay) {
						if (!noMiss)
							noteMiss(daNote.originalType, daNote);
	
						vocals.volume = 0;
						RecalculateRating();
					}

					destroyNote(daNote);
				}
			});
		}

		ZoomCam(focusOnDadGlobal);

		if (!inCutscene && !botPlay)
			keyShit();

		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end

		if (updatevels)
		{
			stupidx *= 0.98;
			stupidy += elapsed * 6;
			if (BAMBICUTSCENEICONHURHURHUR != null)
			{
				BAMBICUTSCENEICONHURHURHUR.x += stupidx;
				BAMBICUTSCENEICONHURHURHUR.y += stupidy;
			}
		}

		if (window == null)
		{
			if (expungedWindowMode)
			{
				#if windows
				popupWindow();
				#end
			}
			else
			{
				return;
			}
		}
		else if (expungedWindowMode)
		{
			var display = Application.current.window.display.currentMode;

			@:privateAccess
			var dadFrame = dad._frame;
			if (dadFrame == null || dadFrame.frame == null) return; // prevent crashes (i hope)
	  
			var rect = new Rectangle(dadFrame.frame.x, dadFrame.frame.y, dadFrame.frame.width, dadFrame.frame.height);

			expungedScroll.scrollRect = rect;

			window.x = Std.int(expungedOffset.x);
			window.y = Std.int(expungedOffset.y);

			if (!expungedMoving)
			{
				elapsedexpungedtime += elapsed * 9;

				var screenwidth = Application.current.window.display.bounds.width;
				var screenheight = Application.current.window.display.bounds.height;

				var toy = ((-Math.sin((elapsedexpungedtime / 9.5) * 2) * 30 * 5.1) / 1080) * screenheight;
				var tox = ((-Math.cos((elapsedexpungedtime / 9.5)) * 100) / 1980) * screenwidth;

				expungedOffset.x = ExpungedWindowCenterPos.x + tox;
				expungedOffset.y = ExpungedWindowCenterPos.y + toy;

				//center
				Application.current.window.y = Math.round(((screenheight / 2) - (720 / 2)) + (Math.sin((elapsedexpungedtime / 30)) * 80));
				Application.current.window.x = Std.int(windowSteadyX);
				Application.current.window.width = 1280;
				Application.current.window.height = 720;
			}

			if (lastFrame != null && dadFrame != null && lastFrame.name != dadFrame.name)
			{
				expungedSpr.graphics.clear();
				generateWindowSprite();
				lastFrame = dadFrame;
			}

			expungedScroll.x = (((dadFrame.offset.x) - (dad.offset.x)) * expungedScroll.scaleX) + 80;
			expungedScroll.y = (((dadFrame.offset.y) - (dad.offset.y)) * expungedScroll.scaleY);
		}
	}
	

	function FlingCharacterIconToOblivionAndBeyond(e:FlxTimer = null):Void
	{
		iconP2.changeIcon(AUGHHHH);
		
		BAMBICUTSCENEICONHURHURHUR.changeIcon(AHHHHH);
		BAMBICUTSCENEICONHURHURHUR.changeState(iconP2.getState());
		stupidx = -5;
		stupidy = -5;
		updatevels = true;
	}
	function destroyNote(note:Note)
	{
		note.active = false;
		note.visible = false;
		note.kill();
		notes.remove(note, true);
		note.destroy();
	}
	function yFromNoteStrumTime(note:Note, strumLine:FlxSprite, downScroll:Bool):Float
	{
		var change = downScroll ? -1 : 1;
		var speed:Float = SONG.speed;
		if (localFunny == CharacterFunnyEffect.Tristan)
		{
			speed += (Math.sin(elapsedtime / 5)) * 1;
		}
		var val:Float = strumLine.y - (Conductor.songPosition - note.strumTime) * (change * 0.45 * FlxMath.roundDecimal(speed * note.LocalScrollSpeed, 2));
		if (note.isSustainNote && downScroll && note.animation != null)
		{
			if (note.animation.curAnim.name.endsWith('end'))
			{
				val += (note.height * 1.55 * (0.7 / Note.scales[mania]));
			}
			val -= (note.height * 0.2);
		}
		return val;
	}
	function ZoomCam(focusondad:Bool):Void
	{
		var bfplaying:Bool = false;
		if (focusondad)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (!bfplaying)
				{
					if (daNote.mustPress)
					{
						bfplaying = true;
					}
				}
			});
			if (UsingNewCam && bfplaying)
			{
				return;
			}
		}
		if (!lockCam)
		{
			if (focusondad)
			{
				camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'playrobot':
						camFollow.x = dad.getMidpoint().x + 50;
					case 'playrobot-shadow':
						camFollow.x = dad.getMidpoint().x + 50;
						camFollow.y -= 100;
					case 'dave-angey' | 'dave-festival-3d' | 'dave-3d-recursed':
						camFollow.y = dad.getMidpoint().y;
					case 'nofriend':
						camFollow.x = dad.getMidpoint().x + 50;
						camFollow.y = dad.getMidpoint().y - 50;
					case 'bambi-3d' | 'bambi-3d-recursed' | 'bambi-3d-scrapped':
						camFollow.x = dad.getMidpoint().x;
						camFollow.y -= 50;
				}

				if (SONG.song.toLowerCase() == 'warmup')
				{
					tweenCamIn();
				}

				bfNoteCamOffset[0] = 0;
				bfNoteCamOffset[1] = 0;

				camFollow.x += dadNoteCamOffset[0];
				camFollow.y += dadNoteCamOffset[1];
			}
			else
			{
				camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
	
				switch (boyfriend.curCharacter)
				{
					case 'bf-pixel':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 250;
					case 'bf-3d':
						camFollow.y += 100;
					case 'dave-angey':
						camFollow.y = boyfriend.getMidpoint().y;
					case 'bambi-3d' | 'bambi-3d-recursed' | 'bambi-3d-scrapped':
						camFollow.x = boyfriend.getMidpoint().x - 375;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'dave-fnaf':
						camFollow.x += 100;
					case 'shaggy' | 'supershaggy' | 'redshaggy' | 'godshaggy':
						camFollow.x -= 100;
						camFollow.y += 30;
						if (SONG.song.toLowerCase() == 'rano') camFollow.y += 100;
				}
				dadNoteCamOffset[0] = 0;
				dadNoteCamOffset[1] = 0;

				camFollow.x += bfNoteCamOffset[0];
				camFollow.y += bfNoteCamOffset[1];

				if (SONG.song.toLowerCase() == 'warmup')
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.sineInOut});
				}
			}
			switch (SONG.song.toLowerCase())
			{
				case 'escape-from-california':
					camFollow.y += 150;
			}
		}
	}


	function THROWPHONEMARCELLO(e:FlxTimer = null):Void
	{
		STUPDVARIABLETHATSHOULDNTBENEEDED.animation.play("throw_phone");
		new FlxTimer().start(5.5, function(timer:FlxTimer)
		{ 
			if(isStoryMode) {
				FlxG.sound.music.stop();
				nextSong();
			}
			else {
				FlxG.switchState(new FreeplayState());
			}
		});
	}

	function endSong():Void
	{
		switch (curSong.toLowerCase())
		{
			case 'old-house':
				if (FlxG.save.data.oldInsanityBeated)
					{
						CharacterSelectState.unlockCharacter('dave-pre-alpha');
						CharacterSelectState.unlockCharacter('dave-pre-alpha-hd');
					}
				FlxG.save.data.houseBeated = true;

			case 'old-insanity':
				if (FlxG.save.data.houseBeated)
					{
						CharacterSelectState.unlockCharacter('dave-pre-alpha');
						CharacterSelectState.unlockCharacter('dave-pre-alpha-hd');
					}
					FlxG.save.data.oldInsanityBeated = true;
			case 'supernovae':
				if (FlxG.save.data.supernovaeBeated)
					{
						CharacterSelectState.unlockCharacter('bambi-joke');
						CharacterSelectState.unlockCharacter('bambi-old');
					}
				FlxG.save.data.glitchBeated = true;
		
			case 'glitch':
				if (FlxG.save.data.glitchBeated)
					{
						CharacterSelectState.unlockCharacter('bambi-joke');
						CharacterSelectState.unlockCharacter('bambi-old');
					}
				FlxG.save.data.supernovaeBeated = true;	
		}
		inCutscene = false;
		canPause = false;
		if (MathGameState.failedGame)
		{
			MathGameState.failedGame = false;
		}
		if (recursedStaticWeek)
		{
			recursedStaticWeek = false;
		}

		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		if (SONG.validScore && !botPlay && !(!modchartoption && (SONG.song.toLowerCase() == 'cheating' || SONG.song.toLowerCase() == 'rigged' || SONG.song.toLowerCase() == 'unfairness' || SONG.song.toLowerCase() == 'kabunga' || localFunny == CharacterFunnyEffect.Exbungo || localFunny == CharacterFunnyEffect.Recurser || SONG.song.toLowerCase() == 'exploitation')))
		{
			trace("score is valid");

			FlxG.save.data.exploitationState = null;
			FlxG.save.flush();

			#if !switch
			Highscore.saveScore(SONG.song, songScore, storyDifficulty, characteroverride == "none"
				|| characteroverride == "bf" ? "bf" : characteroverride);
			#end
		}

		#if windows
		if (window != null)
		{
			window.close();
			expungedWindowMode = false;
			window = null;
		}
		#end

		if (!botPlay) {
			// Song Character Unlocks (Story Mode)
			if (isStoryMode)
			{
				switch (curSong.toLowerCase())
				{
					case "polygonized":
						CharacterSelectState.unlockCharacter('dave-angey');
				}
			}
			// Song Character Unlocks (Freeplay)
			else
			{
				switch (curSong.toLowerCase())
				{
					case "bonus-song":
						CharacterSelectState.unlockCharacter('dave');
						CharacterSelectState.unlockCharacter('dave-2.5');
						CharacterSelectState.unlockCharacter('dave-2.1');
						CharacterSelectState.unlockCharacter('dave-2.0');
						CharacterSelectState.unlockCharacter('dave-1.0');
						CharacterSelectState.unlockCharacter('dave-alpha-4');
						CharacterSelectState.unlockCharacter('dave-alpha');
					case "insanity-2.5":
						CharacterSelectState.unlockCharacter('dave-annoyed');
						CharacterSelectState.unlockCharacter('dave-annoyed-2.5');
						CharacterSelectState.unlockCharacter('dave-annoyed-2.1');
						CharacterSelectState.unlockCharacter('dave-annoyed-2.0');
					case "old-splitathon":
						CharacterSelectState.unlockCharacter('dave-splitathon-2.0');
						CharacterSelectState.unlockCharacter('dave-splitathon-1.0');
						CharacterSelectState.unlockCharacter('bambi-splitathon-2.0');
						CharacterSelectState.unlockCharacter('bambi-splitathon-1.0');
					case "splitathon":
						CharacterSelectState.unlockCharacter('bambi-splitathon-2.5');
						CharacterSelectState.unlockCharacter('dave-splitathon');
						CharacterSelectState.unlockCharacter('dave-splitathon-2.5');
						CharacterSelectState.unlockCharacter('bambi-splitathon');
					case "cheating":
						if (modchartoption) CharacterSelectState.unlockCharacter('bambi-3d');
						if (modchartoption) CharacterSelectState.unlockCharacter('bambi-3d-old');
					case "cheating-random":
						if (modchartoption) CharacterSelectState.unlockCharacter('random');
					case "bonkers":
						CharacterSelectState.unlockCharacter('longnosejohn');
					case "unfairness":
						if (modchartoption) CharacterSelectState.unlockCharacter('bambi-unfair');
						if (modchartoption) CharacterSelectState.unlockCharacter('bambi-unfair-old');
					case "exploitation":
						if (modchartoption) CharacterSelectState.unlockCharacter('expunged');
					case "furiosity":
						CharacterSelectState.unlockCharacter('furiosity-dave');
						CharacterSelectState.unlockCharacter('furiosity-dave-alpha-4');
					case "polygonized-2.5":
						CharacterSelectState.unlockCharacter('dave-angey-old');
						CharacterSelectState.unlockCharacter('dave-insanity-3d');
					case "old-screwed":
						CharacterSelectState.unlockCharacter('bambi-angey-oldest');
					case "screwed-v2":
						CharacterSelectState.unlockCharacter('bambi-angey-old');
						CharacterSelectState.unlockCharacter('bambi-angey');
					case "vs-dave-rap-two":
						CharacterSelectState.unlockCharacter('old-dave-cool');
					case "vs-dave-thanksgiving":
						CharacterSelectState.unlockCharacter('marcello-dave');
					case "electric-cockaldoodledoo":
						CharacterSelectState.unlockCharacter('cockey');
						CharacterSelectState.unlockCharacter('pissey');
						CharacterSelectState.unlockCharacter('shartey-playable');
					case "eletric-cockadoodledoo":
						CharacterSelectState.unlockCharacter('old-cockey');
						CharacterSelectState.unlockCharacter('old-pissey');
					case "bananacore":
						CharacterSelectState.unlockCharacter('older-cockey');
					case "oppression":
						CharacterSelectState.unlockCharacter('dave-3d-standing-bruh-what');
					case "secret-mod-leak":
						CharacterSelectState.unlockCharacter('tb-funny-man');
					case "master":
						CharacterSelectState.unlockCharacter('bambi-joke-mad');
					case "corn-theft-2.5":
						CharacterSelectState.unlockCharacter('bambi-2.5');
					case "blocked-2.5":
						CharacterSelectState.unlockCharacter('bambi-scrapped-3.0');
					case "cuzsie-x-kapi-shipping-cute":
						CharacterSelectState.unlockCharacter('kapi');
					case "old-blocked":
						CharacterSelectState.unlockCharacter('bambi-2.0');
						CharacterSelectState.unlockCharacter('bambi-1.0');
						CharacterSelectState.unlockCharacter('bambi-beta-2');
					case "secret":
						CharacterSelectState.unlockCharacter('mr-bambi');
						CharacterSelectState.unlockCharacter('mr-bambi-car');
						CharacterSelectState.unlockCharacter('mr-bambi-christmas');
						CharacterSelectState.unlockCharacter('mr-bambi-pixel');
						CharacterSelectState.unlockCharacter('mr-bambi-v2');
				}
			}
		}
		switch (SONG.song.toLowerCase())
		{
			case 'supernovae' | 'glitch' | 'master':
				Application.current.window.title = Main.applicationName;
			case 'exploitation':
				FlxG.save.data.exploitationState = '';
				Application.current.window.title = Main.applicationName;
				Main.toggleFuckedFPS(false);
				if (storyDifficulty == 0 && modchartoption) CharacterSelectState.unlockCharacter('godshaggy');
			case 'five-nights':
				FlxG.mouse.visible = false;
			case 'roofs':
				if (storyDifficulty == 0) CharacterSelectState.unlockCharacter('redshaggy');
		}
		if (isStoryMode)
		{
			campaignScore += songScore;

			var completedSongs:Array<String> = [];
			var mustCompleteSongs:Array<String> = ['House', 'Insanity', 'Polygonized', 'Blocked', 'Corn-Theft', 'Maze', 'Splitathon', 'Shredder', 'Greetings', 'Interdimensional', 'Rano'];
			var allSongsCompleted:Bool = true;
		
			if (FlxG.save.data.songsCompleted == null)
			{
				FlxG.save.data.songsCompleted = new Array<String>();
			}
			completedSongs = FlxG.save.data.songsCompleted;
			if (!botPlay) completedSongs.push(storyPlaylist[0]);
			for (i in 0...mustCompleteSongs.length)
			{
				if (!completedSongs.contains(mustCompleteSongs[i]))
				{
					allSongsCompleted = false;
					break;
				}
			}
			if (allSongsCompleted && CharacterSelectState.isLocked('tristan-golden'))
			{
				CharacterSelectState.unlockCharacter('tristan-golden');
				CharacterSelectState.unlockCharacter('tristan-golden-2.5');
			}
			FlxG.save.data.songsCompleted = completedSongs;
			FlxG.save.flush();

			storyPlaylist.remove(storyPlaylist[0]);

			if (storyPlaylist.length <= 0)
			{
				if(FlxTransitionableState.skipNextTransIn)
				{
					Transition.nextCamera = null;
				}
				switch (curSong.toLowerCase())
				{
					case 'polygonized':
						CharacterSelectState.unlockCharacter('tristan');
						CharacterSelectState.unlockCharacter('tristan-2.0');
						CharacterSelectState.unlockCharacter('tristan-beta');
						if (health >= 0.1)
						{
							if (storyDifficulty == 2)
							{
								CharacterSelectState.unlockCharacter('dave-angey');
							}
							FlxG.switchState(new EndingState('goodEnding', 'goodEnding'));
						}
						else if (health < 0.1)
						{
							CharacterSelectState.unlockCharacter('bambi');
							FlxG.switchState(new EndingState('vomit_ending', 'badEnding'));
						}
						else
						{
							FlxG.switchState(new EndingState('badEnding', 'badEnding'));
						}
					case 'maze':
						canPause = false;
						FlxG.sound.music.volume = 0;
						vocals.volume = 0;
						generatedMusic = false; // stop the game from trying to generate anymore music and to just cease attempting to play the music in general
						boyfriend.stunned = true;
						var doof:DialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt('dialogue/maze-endDialogue')));
						doof.scrollFactor.set();
						doof.finishThing = function()
						{
							CharacterSelectState.unlockCharacter('bambi-new');
							FlxG.sound.playMusic(Paths.music('freakyMenu'));
							FlxG.switchState(new StoryMenuState());
						};
						doof.cameras = [camDialogue];
						schoolIntro(doof, false);
					case 'splitathon':
						canPause = false;
						FlxG.sound.music.volume = 0;
						vocals.volume = 0;
						generatedMusic = false; // stop the game from trying to generate anymore music and to just cease attempting to play the music in general
						boyfriend.stunned = true;
						var doof:DialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt('dialogue/splitathon-endDialogue')));
						doof.scrollFactor.set();
						doof.finishThing = function()
						{
							FlxG.sound.playMusic(Paths.music('freakyMenu'));
							FlxG.switchState(new StoryMenuState());
						};
						doof.cameras = [camDialogue];
						schoolIntro(doof, false);
					case 'rano':
						var menu:CreditsMenuState = new CreditsMenuState();
						menu.DoFunnyScroll = true;
						FlxG.switchState(menu);
					default:
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
						FlxG.switchState(new StoryMenuState());
				}
				transIn = FlxTransitionableState.defaultTransIn;
				transOut = FlxTransitionableState.defaultTransOut;

				// if ()
				StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

				if (SONG.validScore && !botPlay)
				{
					Highscore.saveWeekScore(storyWeek, campaignScore,
						storyDifficulty, characteroverride == "none" || characteroverride == "bf" ? "bf" : characteroverride);
				}

				if (!botPlay) FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
				FlxG.save.flush();
			}
			else
			{	if(FlxG.save.data.freeplayCuts){
				switch (SONG.song.toLowerCase())
				{
					case 'insanity' | 'insanity-2.5':
						canPause = false;
						FlxG.sound.music.volume = 0;
						vocals.volume = 0;
						generatedMusic = false; // stop the game from trying to generate anymore music and to just cease attempting to play the music in general
						boyfriend.stunned = true;
						var doof:DialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt('dialogue/insanity-endDialogue')));
						doof.scrollFactor.set();
						doof.finishThing = nextSong;
						doof.cameras = [camDialogue];
						schoolIntro(doof, false);
					case 'splitathon':
						canPause = false;
						FlxG.sound.music.volume = 0;
						vocals.volume = 0;
						generatedMusic = false; // stop the game from trying to generate anymore music and to just cease attempting to play the music in general
						boyfriend.stunned = true;
						var doof:DialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt('dialogue/splitathon-endDialogue')));
						doof.scrollFactor.set();
						doof.finishThing = nextSong;
						doof.cameras = [camDialogue];
						schoolIntro(doof, false);
					case 'greetings':
						isGreetingsCutscene = true;
						greetingsCutsceneSetup();
					case 'interdimensional':
						canPause = false;
						FlxG.sound.music.volume = 0;
						vocals.volume = 0;
						generatedMusic = false; // stop the game from trying to generate anymore music and to just cease attempting to play the music in general
						boyfriend.stunned = true;
						var doof:DialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt('dialogue/interdimensional-endDialogue')), false);
						doof.scrollFactor.set();
						doof.finishThing = nextSong;
						doof.cameras = [camDialogue];
						schoolIntro(doof, false);
					case 'glitch':
						canPause = false;
						FlxG.sound.music.volume = 0;
						vocals.volume = 0;
						var marcello:FlxSprite = new FlxSprite(dad.x - 170, dad.y);
						marcello.flipX = true;
						add(marcello);
						marcello.antialiasing = true;
						marcello.color = 0xFF878787;
						dad.visible = false;
						boyfriend.stunned = true;
						marcello.frames = Paths.getSparrowAtlas('joke/cutscene', 'shared');
						marcello.animation.addByPrefix('throw_phone', 'bambi0', 24, false);
						FlxG.sound.play(Paths.sound('break_phone'), 1, false, null, true);
						boyfriend.playAnim('hit', true);
						STUPDVARIABLETHATSHOULDNTBENEEDED = marcello;
						new FlxTimer().start(5.5, THROWPHONEMARCELLO);
					default:
						nextSong();
				}
			}
			}
		}
		else
		{
			if (storyDifficulty == 0) {
				var completedSongs:Array<String> = [];
				var mustCompleteSongs:Array<String> = ['House', 'Insanity', 'Polygonized', 'Blocked', 'Corn-Theft', 'Maze', 'Splitathon', 'Shredder', 'Greetings', 'Interdimensional', 'Rano'];
				var allSongsCompleted:Bool = true;
			
				if (FlxG.save.data.songsCompletedCanon == null)
				{
					FlxG.save.data.songsCompletedCanon = new Array<String>();
				}
				completedSongs = FlxG.save.data.songsCompletedCanon;
				if (!botPlay) completedSongs.push(curSong);
				for (i in 0...mustCompleteSongs.length)
				{
					if (!completedSongs.contains(mustCompleteSongs[i]))
					{
						allSongsCompleted = false;
						break;
					}
				}
				if (allSongsCompleted && CharacterSelectState.isLocked('supershaggy'))
				{
					CharacterSelectState.unlockCharacter('supershaggy');
				}
				FlxG.save.data.songsCompletedCanon = completedSongs;
				FlxG.save.flush();
			}
			switch (SONG.song.toLowerCase())
			{
				case 'glitch':
					canPause = false;
					FlxG.sound.music.volume = 0;
					vocals.volume = 0;
					var marcello:FlxSprite = new FlxSprite(dad.x, dad.y);
					marcello.flipX = true;
					add(marcello);
					marcello.antialiasing = true;
					marcello.color = getBackgroundColor(curStage);
					dad.visible = false;
					boyfriend.stunned = true;
					marcello.frames = Paths.getSparrowAtlas('joke/cutscene');
					marcello.animation.addByPrefix('throw_phone', 'bambi0', 24, false);
					FlxG.sound.play(Paths.sound('break_phone'), 1, false, null, true);
					boyfriend.playAnim('hit', true);
					STUPDVARIABLETHATSHOULDNTBENEEDED = marcello;
					new FlxTimer().start(5.5, THROWPHONEMARCELLO);
				default:
					if (localFunny == CharacterFunnyEffect.Recurser)
					{
						FlxG.switchState(new FunnyTextState(CoolUtil.coolTextFile(Paths.txt('dialogue/recurser-post'))));
						if(FlxTransitionableState.skipNextTransIn)
						{
							Transition.nextCamera = null;
						}
						return;
					}
					FlxG.switchState(new FreeplayState());
			}
			if(FlxTransitionableState.skipNextTransIn)
			{
				Transition.nextCamera = null;
			}
		}

		deathCounter = 0;
	}

	var endingSong:Bool = false;

	function nextSong()
	{
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		prevCamFollow = camFollow;

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0]);
		FlxG.sound.music.stop();

		switch (curSong.toLowerCase())
		{
			case 'corn-theft':
				playEndCutscene('mazeCutscene');
			default:
				LoadingState.loadAndSwitchState(new PlayState());
		}
	}
	function greetingsCutsceneSetup()
	{
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		prevCamFollow = camFollow;

		SONG = Song.loadFromJson('greetings');
		SONG.player2 = 'dave-festival';
		FlxG.sound.music.stop();
		
		LoadingState.loadAndSwitchState(new PlayState());
	}
	function greetingsCutscene()
	{
		canPause = false;
		boyfriend.canDance = false;
		boyfriend.stunned = false;
		dad.canDance = false;
		dad.playAnim('scared',true);
		gf.canDance = false;

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);

		FlxTween.tween(camHUD, {alpha: 0}, 1);
		FlxG.camera.shake(0.0175, 999);
		FlxG.sound.playMusic(Paths.sound('rumble', 'shared'), 0.8, true, null);
		new FlxTimer().start(2, function(timer:FlxTimer)
		{
			originalPosition = dad.getPosition();
			daveFlying = true;
			
			new FlxTimer().start(3, function(timer:FlxTimer)
			{
				FlxG.sound.play(Paths.sound('transition', 'shared'), 1, false, null, false);
				FlxG.camera.fade(FlxColor.WHITE, 3, false, function()
				{
					daveFlying = false;
					isGreetingsCutscene = false;
					dad.setPosition(originalPosition.x, originalPosition.y);
					camFollow.setPosition(originalPosition.x,originalPosition.y);

					FlxG.camera.stopFX();
					FlxG.camera.fade(FlxColor.BLACK, 0);
					
					FlxG.sound.music.stop();
					FlxG.sound.music.fadeOut(1.9, 0);
					vocals.stop();

					canPause = false;
					hasDialogue = true;

					var doof:DialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt('dialogue/greetings-cutscene')), false);
					doof.scrollFactor.set();
					doof.cameras = [camDialogue];
					doof.finishThing = function()
					{
						new FlxTimer().start(1, function(timer:FlxTimer)
						{
							nextSong();
						});
					};
					schoolIntro(doof, false);
				});
			});
		});
	}

	public function createScorePopUp(daX:Float, daY:Float, autoPos:Bool, daRating:String, daCombo:Int, daStyle:String):Void
	{

		var assetPath:String = '';
		switch (daStyle)
		{
			case '3D' | 'shape':
			  	assetPath = '3D/';
		}

		var placement:String = Std.string(daCombo);

		var coolText:FlxText = new FlxText(daX, daY, 0, placement, 32);
		if (autoPos)
		{
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
		}
		if (FlxG.save.data.noRating) {
		var rating = new FlxSprite().loadGraphic(Paths.image("ui/" + assetPath + daRating));
		rating.screenCenter();
		rating.x = coolText.x - 40;
		rating.y -= 60;
		rating.acceleration.y = 550;
		rating.velocity.y -= FlxG.random.int(140, 175);
		rating.velocity.x -= FlxG.random.int(0, 10);

		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ui/" + assetPath + "combo"));
		comboSpr.screenCenter();
		comboSpr.x = coolText.x;
		comboSpr.acceleration.y = 600;
		comboSpr.velocity.y -= 150;

		comboSpr.velocity.x += FlxG.random.int(1, 10);
		add(rating);
		if (combo >= 10)
		{
			add(comboSpr);
		}

		rating.setGraphicSize(Std.int(rating.width * 0.7));
		rating.antialiasing = true;
		comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
		comboSpr.antialiasing = true;

		comboSpr.updateHitbox();
		rating.updateHitbox();

		var seperatedScore:Array<Int> = [];

		var comboSplit:Array<String> = (daCombo + "").split('');

		if (comboSplit.length == 2)
			seperatedScore.push(0); // make sure theres a 0 in front or it looks weird lol!

		for (i in 0...comboSplit.length)
		{
			var str:String = comboSplit[i];
			seperatedScore.push(Std.parseInt(str));
		}

		var daLoop:Int = 0;
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ui/" + assetPath + "num" + Std.int(i)));
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 80;

			numScore.antialiasing = true;
			numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			numScore.updateHitbox();

			numScore.acceleration.y = FlxG.random.int(200, 300);
			numScore.velocity.y -= FlxG.random.int(140, 160);
			numScore.velocity.x = FlxG.random.float(-5, 5);

			if (daCombo >= 10 || daCombo == 0)
				add(numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
		}
		/* 
			trace(combo);
			trace(seperatedScore);
		*/

		coolText.text = Std.string(seperatedScore);
		// add(coolText);

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		});

		FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				coolText.destroy();
				comboSpr.destroy();

				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.001
		});
	}
	}


	private function popUpScore(strumtime:Float, note:Note):Void
	{
		var noteDiff:Float = Math.abs(strumtime - Conductor.songPosition);
		// boyfriend.playAnim('hey');
		vocals.volume = 1;

		var score:Int = 350;

		var daRating:String = "sick";

		if (!botPlay) {
			if (noteDiff > Conductor.safeZoneOffset * 2)
			{
				daRating = 'shit';
				totalNotesHit -= 2;
				score = 10;
				ss = false;
				shits++;
			}
			else if (noteDiff < Conductor.safeZoneOffset * -2)
			{
				daRating = 'shit';
				totalNotesHit -= 2;
				score = 25;
				ss = false;
				shits++;
			}
			else if (noteDiff > Conductor.safeZoneOffset * 0.45)
			{
				daRating = 'bad';
				score = 100;
				totalNotesHit += 0.2;
				ss = false;
				bads++;
			}
			else if (noteDiff > Conductor.safeZoneOffset * 0.25)
			{
				daRating = 'good';
				totalNotesHit += 0.65;
				score = 200;
				ss = false;
				goods++;
			}
		}
		if (daRating == 'sick')
		{
			totalNotesHit += 1;
			sicks++;

			if(scoreTxtTween != null) 
			{
				scoreTxtTween.cancel();
			}
						
			scoreTxt.scale.x = 1.1;
			scoreTxt.scale.y = 1.1;
			scoreTxtTween = FlxTween.tween(scoreTxt.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					scoreTxtTween = null;
				}
			});
	
			if(healthTxtTween != null) 
			{
				healthTxtTween.cancel();
			}
							
			healthTxt.scale.x = 1.1;
			healthTxt.scale.y = 1.1;
			healthTxtTween = FlxTween.tween(healthTxt.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					healthTxtTween = null;
				}
			});
	
			if(judgementCounterTween != null) 
			{
				judgementCounterTween.cancel();
			}
								
			judgementCounter.scale.x = 1.1;
			judgementCounter.scale.y = 1.1;
			judgementCounterTween = FlxTween.tween(judgementCounter.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					judgementCounterTween = null;
				}
			});
		}
		score = cast(FlxMath.roundDecimal(cast(score, Float) * curmultDefine[note.noteData], 0), Int); //this is old code thats stupid Std.Int exists but i dont feel like changing this

		if (!noMiss)
		{
			songScore += score;
			songHits++;
			RecalculateRating();
		}

		if (!inFiveNights)
		{
			switch (SONG.song.toLowerCase())
			{
				case 'bot-trot':
					createScorePopUp(-400, 300, true, daRating, combo, note.noteStyle);
				default:
					if (isShaggy)
						createScorePopUp(0,-350, true, daRating, combo, note.noteStyle);
					else
						createScorePopUp(0,0, true, daRating, combo, note.noteStyle);
			}
			
		}
		curSection += 1;
	}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
	{
		return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
	}

	var upHold:Bool = false;
	var downHold:Bool = false;
	var rightHold:Bool = false;
	var leftHold:Bool = false;
	var centerHold:Bool = false;

	var l1Hold:Bool = false;
	var uHold:Bool = false;
	var r1Hold:Bool = false;
	var l2Hold:Bool = false;
	var dHold:Bool = false;
	var r2Hold:Bool = false;

	var a0Hold:Bool = false;
	var a1Hold:Bool = false;
	var a2Hold:Bool = false;
	var a3Hold:Bool = false;
	var a4Hold:Bool = false;
	var a5Hold:Bool = false;
	var a6Hold:Bool = false;

	var n0Hold:Bool = false;
	var n1Hold:Bool = false;
	var n2Hold:Bool = false;
	var n3Hold:Bool = false;
	var n4Hold:Bool = false;
	var n5Hold:Bool = false;
	var n6Hold:Bool = false;
	var n7Hold:Bool = false;
	var n8Hold:Bool = false;

	var t0Hold:Bool = false;
	var t1Hold:Bool = false;
	var t2Hold:Bool = false;
	var t3Hold:Bool = false;
	var t4Hold:Bool = false;
	var t5Hold:Bool = false;
	var t6Hold:Bool = false;
	var t7Hold:Bool = false;
	var t8Hold:Bool = false;
	var t9Hold:Bool = false;
	var t10Hold:Bool = false;
	var t11Hold:Bool = false;

	private function keyShit():Void
	{
		// HOLDING
		var up = controls.UP;
		var right = controls.RIGHT;
		var down = controls.DOWN;
		var left = controls.LEFT;
		var center = controls.CENTER;

		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;
		var centerP = controls.CENTER_P;

		var upR = controls.UP_R;
		var rightR = controls.RIGHT_R;
		var downR = controls.DOWN_R;
		var leftR = controls.LEFT_R;
		var centerR = controls.CENTER_R;

		var l1 = controls.L1;
		var u = controls.U1;
		var r1 = controls.R1;
		var l2 = controls.L2;
		var d = controls.D1;
		var r2 = controls.R2;

		var l1P = controls.L1_P;
		var uP = controls.U1_P;
		var r1P = controls.R1_P;
		var l2P = controls.L2_P;
		var dP = controls.D1_P;
		var r2P = controls.R2_P;

		var l1R = controls.L1_R;
		var uR = controls.U1_R;
		var r1R = controls.R1_R;
		var l2R = controls.L2_R;
		var dR = controls.D1_R;
		var r2R = controls.R2_R;

		var a0 = controls.A0;
		var a1 = controls.A1;
		var a2 = controls.A2;
		var a3 = controls.A3;
		var a4 = controls.A4;
		var a5 = controls.A5;
		var a6 = controls.A6;

		var a0P = controls.A0_P;
		var a1P = controls.A1_P;
		var a2P = controls.A2_P;
		var a3P = controls.A3_P;
		var a4P = controls.A4_P;
		var a5P = controls.A5_P;
		var a6P = controls.A6_P;

		var a0R = controls.A0_R;
		var a1R = controls.A1_R;
		var a2R = controls.A2_R;
		var a3R = controls.A3_R;
		var a4R = controls.A4_R;
		var a5R = controls.A5_R;
		var a6R = controls.A6_R;

		var n0 = controls.N0;
		var n1 = controls.N1;
		var n2 = controls.N2;
		var n3 = controls.N3;
		var n4 = controls.N4;
		var n5 = controls.N5;
		var n6 = controls.N6;
		var n7 = controls.N7;
		var n8 = controls.N8;

		var n0P = controls.N0_P;
		var n1P = controls.N1_P;
		var n2P = controls.N2_P;
		var n3P = controls.N3_P;
		var n4P = controls.N4_P;
		var n5P = controls.N5_P;
		var n6P = controls.N6_P;
		var n7P = controls.N7_P;
		var n8P = controls.N8_P;

		var n0R = controls.N0_R;
		var n1R = controls.N1_R;
		var n2R = controls.N2_R;
		var n3R = controls.N3_R;
		var n4R = controls.N4_R;
		var n5R = controls.N5_R;
		var n6R = controls.N6_R;
		var n7R = controls.N7_R;
		var n8R = controls.N8_R;

		var t0 = controls.T0;
		var t1 = controls.T1;
		var t2 = controls.T2;
		var t3 = controls.T3;
		var t4 = controls.T4;
		var t5 = controls.T5;
		var t6 = controls.T6;
		var t7 = controls.T7;
		var t8 = controls.T8;
		var t9 = controls.T9;
		var t10 = controls.T10;
		var t11 = controls.T11;

		var t0P = controls.T0_P;
		var t1P = controls.T1_P;
		var t2P = controls.T2_P;
		var t3P = controls.T3_P;
		var t4P = controls.T4_P;
		var t5P = controls.T5_P;
		var t6P = controls.T6_P;
		var t7P = controls.T7_P;
		var t8P = controls.T8_P;
		var t9P = controls.T9_P;
		var t10P = controls.T10_P;
		var t11P = controls.T11_P;

		var t0R = controls.T0_R;
		var t1R = controls.T1_R;
		var t2R = controls.T2_R;
		var t3R = controls.T3_R;
		var t4R = controls.T4_R;
		var t5R = controls.T5_R;
		var t6R = controls.T6_R;
		var t7R = controls.T7_R;
		var t8R = controls.T8_R;
		var t9R = controls.T9_R;
		var t10R = controls.T10_R;
		var t11R = controls.T11_R;

		var key5 = controls.KEY5 && ((SONG.song.toLowerCase() == 'polygonized' || SONG.song.toLowerCase() == 'interdimensional') && localFunny != CharacterFunnyEffect.Recurser);

		/*if (pressingKey5Global != key5)
		{
			pressingKey5Global = key5;
			regenerateStaticArrows(1, false);
		}*/
		
		playerStrums.forEach(function(strum:StrumNote)
		{
			//trace('global: $pressingKey5Global, none global: ${strum.pressingKey5}');
			
			strum.pressingKey5 = key5;
		});

		var controlArray:Array<Bool> = [leftP, downP, upP, rightP];
		var releaseArray:Array<Bool> = [leftR, downR, upR, rightR];
		if (mania == 1) {
			controlArray = [leftP, downP, centerP, upP, rightP];
			releaseArray = [leftR, downR, centerR, upR, rightR];
		}
		if (mania == 2) {
			controlArray = [l1P, uP, r1P, l2P, dP, r2P];
			releaseArray = [l1R, uR, r1R, l2R, dR, r2R];
		}
		if (mania == 3) {
			controlArray = [a0P, a1P, a2P, a3P, a4P, a5P, a6P];
			releaseArray = [a0R, a1R, a2R, a3R, a4R, a5R, a6R];
		}
		if (mania == 4) {
			controlArray = [n0P, n1P, n2P, n3P, n4P, n5P, n6P, n7P, n8P];
			releaseArray = [n0R, n1R, n2R, n3R, n4R, n5R, n6R, n7R, n8R];
		}
		if (mania == 5) {
			controlArray = [t0P, t1P, t2P, t3P, t4P, t5P, t6P, t7P, t8P, t9P, t10P, t11P];
			releaseArray = [t0R, t1R, t2R, t3R, t4R, t5R, t6R, t7R, t8R, t9R, t10R, t11R];
		}

		if (noteLimbo != null)
		{
			if (noteLimbo.exists)
			{
				if (noteLimbo.wasGoodHit)
				{
					if (key5 && noteLimbo.noteStyle == 'shape')
					{
						goodNoteHit(noteLimbo);
						if (noteLimbo.wasGoodHit)
						{
							noteLimbo.kill();
							notes.remove(noteLimbo, true);
							noteLimbo.destroy();
						}
						noteLimbo = null;
					}
					else if (!key5 && noteLimbo.noteStyle != 'shape')
					{
						goodNoteHit(noteLimbo);
						if (noteLimbo.wasGoodHit)
						{
							noteLimbo.kill();
							notes.remove(noteLimbo, true);
							noteLimbo.destroy();
						}
						noteLimbo = null;
					}
				}
				else
				{
					noteLimbo = null;
				}
			}
		}

		if (noteLimboFrames != 0)
		{
			noteLimboFrames--;
		}
		else
		{
			noteLimbo = null;
		}

		// FlxG.watch.addQuick('asdfa', upP);
		var ankey = (upP || rightP || downP || leftP);
		if (mania == 1) ankey = (upP || rightP || centerP || downP || leftP);
		else if (mania == 2) ankey = (l1P || uP || r1P || l2P || dP || r2P);
		else if (mania == 3) ankey = (a0P || a1P || a2P || a3P || a4P || a5P || a6P);
		else if (mania == 4) ankey = (n0P || n1P || n2P || n3P || n4P || n5P || n6P || n7P || n8P);
		else if (mania == 5) ankey = (t0P || t1P || t2P || t3P || t4P || t5P || t6P || t7P || t8P || t9P || t10P || t11P);
	
		if (ankey && !boyfriend.stunned && generatedMusic)
		{
			boyfriend.holdTimer = 0;

			possibleNotes = [];

			var ignoreList:Array<Int> = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote && daNote.finishedGenerating)
				{
					possibleNotes.push(daNote);
				}
			});

			haxe.ds.ArraySort.sort(possibleNotes, function(a, b):Int {
				var notetypecompare:Int = Std.int(a.noteData - b.noteData);

				if (notetypecompare == 0)
				{
					return Std.int(a.strumTime - b.strumTime);
				}
				return notetypecompare;
			});

			

			if (possibleNotes.length > 0)
			{
				var daNote = possibleNotes[0];

				if (perfectMode)
					noteCheck(true, daNote);

				// Jump notes
				var lasthitnote:Int = -1;
				var lasthitnotetime:Float = -1;

				for (note in possibleNotes) 
				{
					if (!note.mustPress)
					{
						continue; //how did this get here
					}
					if (controlArray[note.noteData % Main.keyAmmo[mania]])
					{ //further tweaks to the conductor safe zone offset multiplier needed.
						if (lasthitnotetime > Conductor.songPosition - Conductor.safeZoneOffset
							&& lasthitnotetime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.08)) //reduce the past allowed barrier just so notes close together that aren't jacks dont cause missed inputs
						{
							if ((note.noteData % Main.keyAmmo[mania]) == (lasthitnote % Main.keyAmmo[mania]))
							{
								lasthitnotetime = -999999; //reset the last hit note time
								continue; //the jacks are too close together
							}
						}
						if (note.noteStyle == 'shape' && !key5)
						{
							//FlxG.sound.play(Paths.sound('ANGRY'), FlxG.random.float(0.2, 0.3));
							noteLimbo = note;
							noteLimboFrames = 8; //note limbo, the place where notes that could've been hit go.
							continue;
						}
						else if (note.noteStyle != 'shape' && key5)
						{
							//FlxG.sound.play(Paths.sound('ANGRY'), FlxG.random.float(0.2, 0.3));
							noteLimbo = note;
							noteLimboFrames = 8;
							continue;
						}
						lasthitnote = note.noteData;
						lasthitnotetime = note.strumTime;
						goodNoteHit(note);
					}
				}
				
				if (daNote.wasGoodHit && !daNote.isSustainNote)
				{
					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			}
			else if (!theFunne)
			{
				if(!inCutscene)
					badNoteCheck(null);
			}
		}

		var condition = up || right || down || left;
		if (mania == 1) condition = up || right || center || down || left;
		else if (mania == 2) condition = l1 || u || r1 || l2 || d || r2;
		else if (mania == 3) condition = a0 || a1 || a2 || a3 || a4 || a5 || a6;
		else if (mania == 4) condition = n0 || n1 || n2 || n3 || n4 || n5 || n6 || n7 || n8;
		else if (mania == 5) condition = t0 || t1 || t2 || t3 || t4 || t5 || t6 || t7 || t8 || t9 || t10 || t11;
		if (condition && generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
				{
					if ((daNote.noteStyle == 'shape' && key5) || (daNote.noteStyle != 'shape' && !key5))
					{
						if (mania == 0)
						{
							switch (daNote.noteData)
							{
								// NOTES YOU ARE HOLDING
								case 2:
									if (up || upHold)
										goodNoteHit(daNote);
								case 3:
									if (right || rightHold)
										goodNoteHit(daNote);
								case 1:
									if (down || downHold)
										goodNoteHit(daNote);
								case 0:
									if (left || leftHold)
										goodNoteHit(daNote);
							}
						}
						else if (mania == 1)
						{
							switch (daNote.noteData)
							{
								// NOTES YOU ARE HOLDING
								case 0: if (left || leftHold) goodNoteHit(daNote);
								case 1: if (down || downHold) goodNoteHit(daNote);
								case 2: if (center || centerHold) goodNoteHit(daNote);
								case 3: if (up || upHold) goodNoteHit(daNote);
								case 4: if (right || rightHold) goodNoteHit(daNote);
							}
						}
						else if (mania == 2)
						{
							switch (daNote.noteData)
							{
								// NOTES YOU ARE HOLDING
								case 0:
									if (l1 || l1Hold)
										goodNoteHit(daNote);
								case 1:
									if (u || uHold)
										goodNoteHit(daNote);
								case 2:
									if (r1 || r1Hold)
										goodNoteHit(daNote);
								case 3:
									if (l2 || l2Hold)
										goodNoteHit(daNote);
								case 4:
									if (d || dHold)
										goodNoteHit(daNote);
								case 5:
									if (r2 || r2Hold)
										goodNoteHit(daNote);
							}
						}
						else if (mania == 3)
						{
							switch (daNote.noteData)
							{
								// NOTES YOU ARE HOLDING
								case 0: if (a0 || a0Hold) goodNoteHit(daNote);
								case 1: if (a1 || a1Hold) goodNoteHit(daNote);
								case 2: if (a2 || a2Hold) goodNoteHit(daNote);
								case 3: if (a3 || a3Hold) goodNoteHit(daNote);
								case 4: if (a4 || a4Hold) goodNoteHit(daNote);
								case 5: if (a5 || a5Hold) goodNoteHit(daNote);
								case 6: if (a6 || a6Hold) goodNoteHit(daNote);
							}
						}
						else if (mania == 4)
						{
							switch (daNote.noteData)
							{
								// NOTES YOU ARE HOLDING
								case 0: if (n0 || n0Hold) goodNoteHit(daNote);
								case 1: if (n1 || n1Hold) goodNoteHit(daNote);
								case 2: if (n2 || n2Hold) goodNoteHit(daNote);
								case 3: if (n3 || n3Hold) goodNoteHit(daNote);
								case 4: if (n4 || n4Hold) goodNoteHit(daNote);
								case 5: if (n5 || n5Hold) goodNoteHit(daNote);
								case 6: if (n6 || n6Hold) goodNoteHit(daNote);
								case 7: if (n7 || n7Hold) goodNoteHit(daNote);
								case 8: if (n8 || n8Hold) goodNoteHit(daNote);
							}
						}
						else if (mania == 5)
						{
							switch (daNote.noteData)
							{
								// NOTES YOU ARE HOLDING
								case 0: if (t0 || t0Hold) goodNoteHit(daNote);
								case 1: if (t1 || t1Hold) goodNoteHit(daNote);
								case 2: if (t2 || t2Hold) goodNoteHit(daNote);
								case 3: if (t3 || t3Hold) goodNoteHit(daNote);
								case 4: if (t4 || t4Hold) goodNoteHit(daNote);
								case 5: if (t5 || t5Hold) goodNoteHit(daNote);
								case 6: if (t6 || t6Hold) goodNoteHit(daNote);
								case 7: if (t7 || t7Hold) goodNoteHit(daNote);
								case 8: if (t8 || t8Hold) goodNoteHit(daNote);
								case 9: if (t9 || t9Hold) goodNoteHit(daNote);
								case 10: if (t10 || t10Hold) goodNoteHit(daNote);
								case 11: if (t11 || t11Hold) goodNoteHit(daNote);
							}
						}
					}
				}
			});
		}

		if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && !condition)
		{
			if ((boyfriend.animation.curAnim.name.startsWith('sing')) && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				boyfriend.dance();
				
				bfNoteCamOffset[0] = 0;
				bfNoteCamOffset[1] = 0;
			}
		}

		playerStrums.forEach(function(spr:StrumNote)
		{
			if (controlArray[spr.ID] && spr.animation.curAnim.name != 'confirm')
			{
				spr.playAnim('pressed');
			}
			if (releaseArray[spr.ID])
			{
				spr.playAnim('static');
			}
		});
	}

	function noteMiss(direction:Int = 1, note:Note):Void
	{
		if (true)
		{
			misses++;	
			if (inFiveNights)
			{
				health -= 0.004;
			}
			else
			{
				health -= 0.04;
			}
			if (combo > 5)
			{
				gf.playAnim('sad');
			}
			combo = 0;
			songScore -= 100;
			RecalculateRating();

			if (note != null)
			{
				switch (note.noteStyle)
				{
					case 'text':
						recursedNoteMiss();
					case 'phone':
						var hitAnimation:Bool = boyfriend.animation.getByName("hit") != null;
						boyfriend.playAnim(hitAnimation ? 'hit' : (isShaggy ? 'singDOWNmiss' : 'singRIGHTmiss'), true);
						if (isShaggy) boyfriend.color = 0xFF000084;
						FlxTween.cancelTweensOf(note.MyStrum);
						note.MyStrum.alpha = 0.01;
						var noteTween = FlxTween.tween(note.MyStrum, {alpha: 1}, 7, {ease: FlxEase.expoIn});
						pauseTweens.push(noteTween);
						health -= 0.07;
						updateAccuracy();
						return;
					case 'phone-zardy':
						var Animation:Bool = boyfriend.animation.getByName("singSmash") != null;
						boyfriend.playAnim(boyfriend.animation.getByName("singSmash") == null ? 'singSmash' : 'singSmash', true);
						return;
				}
			}
			var deathSound:FlxSound = new FlxSound();
			switch (curSong.toLowerCase())
			{
				case 'overdrive':
					deathSound.loadEmbedded(Paths.sound('bad_disc'));
				case 'vs-dave-rap' | 'vs-dave-rap-two':
					deathSound.loadEmbedded(Paths.sound('deathbell'));
				default:
					deathSound.loadEmbedded(Paths.soundRandom('missnote', 1, 3));
			}
			deathSound.volume = FlxG.random.float(0.1, 0.2);
			deathSound.play();

			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');
			
			var noteTypes = guitarSection ? notestuffsGuitar : notestuffs;
			var noteToPlay:String = noteTypes[Math.round(Math.abs(direction)) % playerStrumAmount];
			if (!boyfriend.nativelyPlayable)
			{
				switch (noteToPlay)
				{
					case 'LEFT':
						noteToPlay = 'RIGHT';
					case 'RIGHT':
						noteToPlay = 'LEFT';
				}
			}
			if (boyfriend.animation.getByName('sing${noteToPlay}miss') != null)
			{
				boyfriend.playAnim('sing' + noteToPlay + "miss", true);
			}
			else
			{
				boyfriend.color = 0xFF000084;
				boyfriend.playAnim('sing' + noteToPlay, true);
			}
			updateAccuracy();
		}
	}

	function cameraMoveOnNote(move:String, character:String)
	{
		var amount:Array<Float> = new Array<Float>();
		var followAmount:Float = FlxG.save.data.noteCamera ? 20 : 0;
		switch (move)
		{
			case 'LEFT':
				amount[0] = -followAmount;
				amount[1] = 0;
			case 'DOWN':
				amount[0] = 0;
				amount[1] = followAmount;
			case 'UP':
				amount[0] = 0;
				amount[1] = -followAmount;
			case 'RIGHT':
				amount[0] = followAmount;
				amount[1] = 0;
		}
		switch (character)
		{
			case 'dad':
				dadNoteCamOffset = amount;
			case 'bf':
				bfNoteCamOffset = amount;
		}
	}

	function badNoteCheck(note:Note = null)
	{
		// just double pasting this shit cuz fuk u
		// REDO THIS SYSTEM!
		if (note != null)
		{
			if(note.mustPress && note.finishedGenerating)
			{
				if (!noMiss)
					noteMiss(note.noteData, note);
			}
			return;
		}
		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;
		var centerP = controls.CENTER_P;

		var l1P = controls.L1_P;
		var uP = controls.U1_P;
		var r1P = controls.R1_P;
		var l2P = controls.L2_P;
		var dP = controls.D1_P;
		var r2P = controls.R2_P;

		var a0P = controls.A0_P;
		var a1P = controls.A1_P;
		var a2P = controls.A2_P;
		var a3P = controls.A3_P;
		var a4P = controls.A4_P;
		var a5P = controls.A5_P;
		var a6P = controls.A6_P;

		var n0P = controls.N0_P;
		var n1P = controls.N1_P;
		var n2P = controls.N2_P;
		var n3P = controls.N3_P;
		var n4P = controls.N4_P;
		var n5P = controls.N5_P;
		var n6P = controls.N6_P;
		var n7P = controls.N7_P;
		var n8P = controls.N8_P;

		var t0P = controls.T0_P;
		var t1P = controls.T1_P;
		var t2P = controls.T2_P;
		var t3P = controls.T3_P;
		var t4P = controls.T4_P;
		var t5P = controls.T5_P;
		var t6P = controls.T6_P;
		var t7P = controls.T7_P;
		var t8P = controls.T8_P;
		var t9P = controls.T9_P;
		var t10P = controls.T10_P;
		var t11P = controls.T11_P;

		var controlArray:Array<Bool> = [leftP, downP, upP, rightP];
		if (mania == 1) controlArray = [leftP, downP, centerP, upP, rightP];
		if (mania == 2) controlArray = [l1P, uP, r1P, l2P, dP, r2P];
		if (mania == 3) controlArray = [a0P, a1P, a2P, a3P, a4P, a5P, a6P];
		if (mania == 4) controlArray = [n0P, n1P, n2P, n3P, n4P, n5P, n6P, n7P, n8P];
		if (mania == 5) controlArray = [t0P, t1P, t2P, t3P, t4P, t5P, t6P, t7P, t8P, t9P, t10P, t11P];

		for (i in 0...controlArray.length)
		{
			if (controlArray[i])
			{
				if (!noMiss)
					noteMiss(i, note);
			}	
		}
		updateAccuracy();
	}

	function updateAccuracy()
	{
		if (misses > 0 || accuracy < 96)
			fc = false;
		else
			fc = true;
		totalPlayed += 1;
		accuracy = totalNotesHit / totalPlayed * 100;
		judgementCounter.text = 'Sicks: ${sicks}\nGoods: ${goods}\nBads: ${bads}\nMisses: ${misses}';
	}

	function noteCheck(keyP:Bool, note:Note):Void // sorry lol
	{
		if (keyP)
		{
			goodNoteHit(note);
		}
		else if (!theFunne && !botPlay)
		{
			badNoteCheck(note);
		}
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			if (!note.isSustainNote)
			{
				combo += 1;
				popUpScore(note.strumTime, note);
				if (FlxG.save.data.donoteclick)
				{
					FlxG.sound.play(Paths.sound('note_click'));
				}
				notesHitArray.push(Date.now());

				if(combo%10 + 1 == 1){

					// Flashes on x10 combo
					if(FlxG.save.data.comboFlash){
						var color:FlxColor = 0xffbff5f5;
						color.alphaFloat = 0.8;
						camGame.flash(color, 0.3);
					}

					// GF blup on x10 combo
					if(FlxG.save.data.comboSound){
						FlxG.sound.play(Paths.soundRandom('GF_', 1, 4));
					}

				}
			}
			else
				totalNotesHit += 1;

			if (!isRecursed)
			{
				if (inFiveNights)
				{
					health += 0.0023;
				}
				else
				{
					health += 0.023;
				}
			}
			if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized" && formoverride != 'tristan-golden-glowing' && bfTween == null)
			{
				boyfriend.color = nightColor;
			}
			else if (sunsetLevels.contains(curStage) && bfTween == null)
			{
				boyfriend.color = sunsetColor;
			}
			else if (bfTween == null)
			{
				boyfriend.color = FlxColor.WHITE;
			}
			else
			{
				if (!bfTween.active && !bfTween.finished)
				{
					bfTween.active = true;
				}
				boyfriend.color = bfTween.color;
			}

			if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized-2.5" && formoverride != 'tristan-golden-glowing' && bfTween == null)
				{
					boyfriend.color = nightColor;
				}
				else if (sunsetLevels.contains(curStage) && bfTween == null)
				{
					boyfriend.color = sunsetColor;
				}
				else if (bfTween == null)
				{
					boyfriend.color = FlxColor.WHITE;
				}
				else
				{
					if (!bfTween.active && !bfTween.finished)
					{
						bfTween.active = true;
					}
					boyfriend.color = bfTween.color;
				}


			switch (note.noteStyle)
			{
				default:
					//'LEFT', 'DOWN', 'UP', 'RIGHT'

					var fuckingDumbassBullshitFuckYou:String;
					var noteTypes = guitarSection ? notestuffsGuitar : notestuffs;
					fuckingDumbassBullshitFuckYou = noteTypes[Math.round(Math.abs(note.originalType)) % playerStrumAmount];
					if(!boyfriend.nativelyPlayable)
					{
						switch(noteTypes[Math.round(Math.abs(note.originalType)) % playerStrumAmount])
						{
							case 'LEFT':
								fuckingDumbassBullshitFuckYou = 'RIGHT';
							case 'RIGHT':
								fuckingDumbassBullshitFuckYou = 'LEFT';
						}
					}
					boyfriend.playAnim('sing' + fuckingDumbassBullshitFuckYou, true);
					cameraMoveOnNote(fuckingDumbassBullshitFuckYou, 'bf');
				case 'phone-zardy':
					var Animation:Bool = boyfriend.animation.getByName("singSmash") != null;
					var heyAnimation:Bool = boyfriend.animation.getByName("hey") != null;
					boyfriend.playAnim(Animation ? 'singSmash' : (heyAnimation ? 'hey' : (isShaggy ? 'singRIGHT' : 'singUPmiss')), true);
				case 'phone':
					var hitAnimation:Bool = boyfriend.animation.getByName("dodge") != null;
					var heyAnimation:Bool = boyfriend.animation.getByName("hey") != null;
					boyfriend.playAnim(hitAnimation ? 'dodge' : (heyAnimation ? 'hey' : (isShaggy ? 'singRIGHT' : 'singUPmiss')), true);
					gf.playAnim('cheer', true);
					if (note.health != 2)
					{
						dad.playAnim(dad.animation.getByName("singThrow") == null ? 'singSmash' : 'singThrow', true);
					}
			}
			if (UsingNewCam)
			{
				focusOnDadGlobal = false;
				ZoomCam(false);
			}

			playerStrums.forEach(function(spr:StrumNote)
			{
				if(botPlay) {
					if (Math.abs(Math.round(Math.abs(note.noteData)) % playerStrumAmount) == spr.ID)
					{
						spr.playAnim('confirm', true);
						spr.animation.finishCallback = function(name:String)
						{
							spr.playAnim('static', true);
						}
					}
					spr.pressingKey5 = note.noteStyle == 'shape';
				} else {
					if (Math.abs(note.noteData) == spr.ID)
					{
						spr.playAnim('confirm', true);
					}
				}
			});

			if (isRecursed && !note.isSustainNote)
			{
				noteCount++;
				notesLeftText.text = noteCount + '/' + notesLeft;

				if (noteCount >= notesLeft)
				{
					removeRecursed();
				}
			}

			note.wasGoodHit = true;
			vocals.volume = 1;

			if (!note.isSustainNote)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}

			updateAccuracy();
		}
	}
	function recursedNoteMiss()
	{
		if (!isRecursed)
		{
			missedRecursedLetterCount++;
			var recursedCover = new FlxSprite().loadGraphic(Paths.image('recursed/recursedX'));
			recursedCover.x = (boyfriend.getGraphicMidpoint().x - boyfriend.width / 2) + new FlxRandom().float(-recursedCover.width, recursedCover.width);
			recursedCover.y = (boyfriend.getGraphicMidpoint().y - boyfriend.height / 2) + new FlxRandom().float(-recursedCover.height, recursedCover.height) / 2;

			recursedCover.angle = new FlxRandom().float(0, 180);
			
			recursedCovers.add(recursedCover);
			add(recursedCover);

			FlxG.camera.shake(0.012 * missedRecursedLetterCount, 0.5);
			if (missedRecursedLetterCount > new FlxRandom().int(2, 5))
			{
				turnRecursed();
			}
		}
		else
		{
			FlxG.camera.shake(0.02, 0.5);
			timeLeft -= 5;
		}
	}
	function turnRecursed()
	{
		preRecursedHealth = health;
		isRecursed = true;
		missedRecursedLetterCount = 0;
		for (cover in recursedCovers)
		{
			recursedCovers.remove(cover);
			remove(cover);
		}
		FlxG.camera.flash();
		
		switch (boyfriend.curCharacter)
		{
			case 'tristan-golden' | 'tristan-golden-glowing':
				FlxG.sound.play(Paths.sound('recursed/boom', 'shared'), 1.5, false);
				for (i in 0...15)
				{
					var goldenPiece = new FlxSprite(boyfriend.getGraphicMidpoint().x + FlxG.random.int(-200, 100), boyfriend.getGraphicMidpoint().y);
					goldenPiece.frames = Paths.getSparrowAtlas('recursed/gold_pieces_but_not_broken', 'shared');
					goldenPiece.animation.addByPrefix('piece', 'gold piece ${FlxG.random.int(1, 4)}', 0, false);
					goldenPiece.animation.play('piece');
					add(goldenPiece);

					goldenPiece.angularVelocity = 50;
				
					goldenPiece.acceleration.y = 600;
					goldenPiece.velocity.y -= FlxG.random.int(300, 400);
					goldenPiece.velocity.x -= FlxG.random.int(-100, 100);
					goldenPiece.angularAcceleration = 200;

					FlxTween.tween(goldenPiece, {alpha: 0}, 2, {onComplete: function(tween:FlxTween)
					{
						remove(goldenPiece);
					}});

					if (boyfriend.curCharacter == 'tristan-golden-glowing') {
						boyfriend.color = nightColor;
					}
				}
		}
		if (!isShaggy) {
			preRecursedSkin = (formoverride != 'none' && boyfriend.curCharacter == formoverride ? formoverride : boyfriend.curCharacter);
			if (boyfriend.skins.exists('recursed'))
			{
				switchBF(boyfriend.skins.get('recursed'), boyfriend.getPosition());
			}
			bfGroup.add(boyfriend);
		}
		addRecursedUI();		
	}
	function addRecursedUI()
	{
		timeGiven = Math.round(new FlxRandom().float(25, 35));
		timeLeft = timeGiven;
		notesLeft = new FlxRandom().int(65, 100);
		noteCount = 0;

		var yOffset = healthBar.y - 50;

		notesLeftText = new FlxText((FlxG.width / 2) - 200, yOffset, 0, noteCount + '/' + notesLeft, 60);
		notesLeftText.setFormat("Comic Sans MS Bold", 30, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		notesLeftText.scrollFactor.set();
		notesLeftText.borderSize = 2.5;
		notesLeftText.antialiasing = true;
		notesLeftText.cameras = [camHUD];
		add(notesLeftText);
		recursedUI.add(notesLeftText);

		var noteIcon:FlxSprite = new FlxSprite(notesLeftText.x + notesLeftText.width + 10, notesLeftText.y - 15).loadGraphic(Paths.image('recursed/noteIcon', 'shared'));
		noteIcon.scrollFactor.set();
		noteIcon.setGraphicSize(Std.int(noteIcon.width * 0.4));
		noteIcon.updateHitbox();
		noteIcon.cameras = [camHUD];
		add(noteIcon);
		recursedUI.add(noteIcon);

		timeLeftText = new FlxText((FlxG.width / 2) + 100, yOffset, 0, FlxStringUtil.formatTime(timeLeft), 60);
		timeLeftText.setFormat("Comic Sans MS Bold", 30, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeLeftText.scrollFactor.set();
		timeLeftText.borderSize = 2.5;
		timeLeftText.antialiasing = true;
		timeLeftText.cameras = [camHUD];
		add(timeLeftText);
		recursedUI.add(timeLeftText);

		var timerIcon:FlxSprite = new FlxSprite(timeLeftText.x + timeLeftText.width + 20, timeLeftText.y - 7).loadGraphic(Paths.image('recursed/timerIcon', 'shared'));
		timerIcon.scrollFactor.set();
		timerIcon.setGraphicSize(Std.int(timerIcon.width * 0.4));
		timerIcon.updateHitbox();
		timerIcon.cameras = [camHUD];
		add(timerIcon);
		recursedUI.add(timerIcon);

		rotateRecursedCam();
	}
	function removeRecursed()
	{
		FlxG.camera.flash();
		
		cancelRecursedCamTween();

		isRecursed = false;
		for (element in recursedUI)
		{
			recursedUI.remove(element);
			remove(element);
		}
		if (!isShaggy) switchBF(preRecursedSkin, boyfriend.getPosition());
		health = preRecursedHealth;
	}
	function initAlphabet(songList:Array<String>)
	{
		for (letter in alphaCharacters)
		{
			alphaCharacters.remove(letter);
			remove(letter);
		}
		var startWidth = 640;
		var width:Float = startWidth;
		var row:Float = 0;
		
		while (row < FlxG.height)
		{
			while (width < FlxG.width * 2.5)
			{
				for (i in 0...songList.length)
				{
					var curSong = songList[i];
					var song = new Alphabet(0, 0, curSong, true);
					song.x = width;
					song.y = row;

					width += song.width + 20;
					alphaCharacters.add(song);
					add(song);
					
					if (width > FlxG.width * 2.5)
					{
						break;
					}
				}
			}
			row += 120;
			width = startWidth;
		}
		for (char in alphaCharacters)
		{
			for (letter in char.characters)
			{
				letter.alpha = 0;
			}
		}
		for (char in alphaCharacters)
		{
			char.unlockY = true;
			for (alphaChar in char.characters)
			{
				alphaChar.velocity.set(new FlxRandom().float(-50, 50), new FlxRandom().float(-50, 50));
				alphaChar.angularVelocity = new FlxRandom().int(30, 50);

				alphaChar.setPosition(new FlxRandom().float(-FlxG.width / 2, FlxG.width * 2.5), new FlxRandom().float(0, FlxG.height * 2.5));
			}
		}
	}
	function rotateRecursedCam()
	{
		rotatingCamTween = FlxTween.tween(FlxG.camera, {angle: 8}, 5, {onComplete: function(tween:FlxTween)
		{
			FlxTween.tween(FlxG.camera, {angle: -8}, 5);
		}, type: FlxTweenType.ONESHOT, ease: FlxEase.backOut});
	}
	function cancelRecursedCamTween()
	{
		if (rotatingCamTween != null)
		{
			rotatingCamTween.cancel();
			rotatingCamTween = null;
	
			camRotateAngle = 0;
			
			FlxG.camera.angle = 0;
			camHUD.angle = 0;
		}
	}
	function cinematicBars(time:Float, closeness:Float)
	{
		var upBar = new FlxSprite().makeGraphic(Std.int(FlxG.width * ((1 / defaultCamZoom) * 2)), Std.int(FlxG.height / 2), FlxColor.BLACK);
		var downBar = new FlxSprite().makeGraphic(Std.int(FlxG.width * ((1 / defaultCamZoom) * 2)), Std.int(FlxG.height / 2), FlxColor.BLACK);

		upBar.screenCenter();
		downBar.screenCenter();
		upBar.scrollFactor.set();
		downBar.scrollFactor.set();
		upBar.cameras = [camHUD];
		downBar.cameras = [camHUD];

		upBar.y -= 2000;
		downBar.y += 2000;

		add(upBar);
		add(downBar);
		
		FlxTween.tween(upBar, {y: (FlxG.height - upBar.height) / 2 - closeness}, (Conductor.crochet / 1000) / 2, {ease: FlxEase.expoInOut, onComplete: function(tween:FlxTween)
		{
			new FlxTimer().start(time, function(timer:FlxTimer)
			{
				FlxTween.tween(upBar, {y: upBar.y - 2000}, (Conductor.crochet / 1000) / 2, {ease: FlxEase.expoIn, onComplete: function(tween:FlxTween)
				{
					remove(upBar);
				}});
			});
		}});
		FlxTween.tween(downBar, {y: (FlxG.height - downBar.height) / 2 + closeness}, (Conductor.crochet / 1000) / 2, {ease: FlxEase.expoInOut, onComplete: function(tween:FlxTween)
		{
			new FlxTimer().start(time, function(timer:FlxTimer)
			{
				FlxTween.tween(downBar, {y: downBar.y + 2000}, (Conductor.crochet / 1000) / 2, {ease: FlxEase.expoIn, onComplete: function(tween:FlxTween)
				{
					remove(downBar);
				}});
			});
		}});
	}
	function swapGlitch(glitchTime:Float, toBackground:String)
	{
		//hey t5 if you make the static fade in and out, can you use the sounds i made? they are in preload
		var glitch = new BGSprite('glitch', 0, 0, 'ui/glitch/glitchSwitch', 
		[
			new Animation('glitch', 'glitchScreen', 24, true, [false, false])
		], 0, 0, false, true);
		glitch.scrollFactor.set();
		glitch.cameras = [camHUD];
		glitch.setGraphicSize(FlxG.width, FlxG.height);
		glitch.updateHitbox();
		glitch.screenCenter();
		if (FlxG.save.data.eyesores)
		{
			glitch.animation.play('glitch');
		}
		add(glitch);

		new FlxTimer().start(glitchTime, function(timer:FlxTimer)
		{
			expungedBG.setPosition(0, 200);
			switch (toBackground)
			{
				case 'expunged':
					expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/creepyRoom', 'shared'));
					expungedBG.setGraphicSize(Std.int(expungedBG.width * 2));
				case 'cheating':
					expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/cheater GLITCH'));
					expungedBG.setGraphicSize(Std.int(expungedBG.width * 3));
				case 'cheating-2':
					expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/glitchy_cheating_2'));
					expungedBG.setGraphicSize(Std.int(expungedBG.width * 3));
				case 'unfair':
					expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/glitchyUnfairBG'));
					expungedBG.setGraphicSize(Std.int(expungedBG.width * 3));
				case 'chains':
					expungedBG.setPosition(-300, 0);
					expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/expunged_chains'));
					expungedBG.setGraphicSize(Std.int(expungedBG.width * 2));
			}
			remove(glitch);
		});
	}
	var black:FlxSprite;
	var vineBoomTriggers:Array<Int> = [524, 588, 666, 720, 736, 752, 1088, 1092, 1096, 1100, 1152, 1168, 1172, 1174, 1176, 1180, 2113, 2144, 2176];
	var newvineBoomTriggers:Array<Int> = [524, 588, 666];
	var shag:FlxSprite;
	var indihome:FlxSprite;
	var jumpscare = new FlxSprite();
	var noteWarning = new FlxSprite();
	var nimbi = new FlxSprite();
	var hideStuff:FlxSprite;
	var sexDad:Character;
	var shapeNoteWarning2 = new FlxSprite();
	var curECCCharacter:String = "cockey";
	var staticBG = new FlxSprite();

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
			resyncVocals();

		switch (SONG.song.toLowerCase())
		{
			case 'mastered':
				switch (curStep)
				{
					case 384 | 895 | 1412:
						blue3d.visible = true;
					case 639 | 1152 | 1919:
						blue3d.visible = false;
					case 1152:
						redbg.visible = true;
					case 1176:
						blue3d.visible = true;
						redbg.visible = false;
				        case 639 | 1152 | 1919:
						blue3d.visible = false;
						redbg.visible = false;
					case 2047:
						if (misses > 0) {
							dad.animation.play('damn', true);
						}
						else if (misses > 20) {
							dad.animation.play('bro', true);
					        }
						else if (botPlay) {
							dad.animation.play('bro', true);
					        }
				}

			case 'blocked':
				switch (curStep)
				{
					case 128:
						defaultCamZoom += 0.1;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub1'), 0.02, 1);
					case 165:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub2'), 0.02, 1);
					case 188:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub3'), 0.02, 1);
					case 224:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub4'), 0.02, 1);
					case 248:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub5'), 0.02, 0.5, {subtitleSize: 60});
					case 256:
						defaultCamZoom -= 0.1;
						FlxG.camera.flash();
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 640:
						FlxG.camera.flash();
						black.alpha = 0.6;
						defaultCamZoom += 0.1;
					case 768:
						FlxG.camera.flash();
						defaultCamZoom -= 0.1;
						black.alpha = 0;
					case 1028:
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub6'), 0.02, 1.5);
					case 1056:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub7'), 0.02, 1);
					case 1084:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub8'), 0.02, 1);
					case 1104:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub9'), 0.02, 1);
					case 1118:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub10'), 0.02, 1);
					case 1143:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub11'), 0.02, 1, {subtitleSize: 45});
						makeInvisibleNotes(false);
					case 1152:
						FlxTween.tween(black, {alpha: 0.4}, 1);
						defaultCamZoom += 0.3;
					case 1200:
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
							{
								camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
							}
						#end
						FlxTween.tween(black, {alpha: 0.7}, (Conductor.stepCrochet / 1000) * 8);
					case 1216:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						camHUD.setFilters([]);
						remove(black);
						defaultCamZoom -= 0.3;
				}
			case 'cozen':
				switch (curStep)
				{
					case 1800:
						subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub10'), 0.02, 0.6);
			                case 2328:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub1'), 0.02, 0.6);
					case 2355:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub2'), 0.02, 0.6);
					case 2388:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub3'), 0.02, 1.5);
					case 2432:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub4'), 0.02, 1.5);
					case 2464:
			                        subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub5'), 0.02, 1);
					case 2479:
			                        subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub6'), 0.02, 1);
					case 2493:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub7'), 0.02, 1);
					case 2525:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub8'), 0.02, 1);
					case 2554:
				                subtitleManager.addSubtitle(LanguageManager.getTextString('cozen_sub9'), 0.02, 1);
					case 2576:
					        FlxG.camera.flash(FlxColor.WHITE, 1);
					        dad.visible = false;
					        iconP2.visible = false;
				}
			case 'corn-theft':
				switch (curStep)
				{
					case 668:
						defaultCamZoom += 0.1;
					case 784:
						defaultCamZoom += 0.1;
					case 848:
						defaultCamZoom -= 0.2;
					case 916:
						FlxG.camera.flash();
					case 935:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub1'), 0.02, 1);
					case 945:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub2'), 0.02, 1);
					case 976:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub3'), 0.02, 0.5);
					case 982:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub4'), 0.02, 1);
					case 992:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub5'), 0.02, 1);
					case 1002:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub6'), 0.02, 0.3);
					case 1007:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub7'), 0.02, 0.3);
					case 1033:
						subtitleManager.addSubtitle("Bye Baa!", 0.02, 0.3, {subtitleSize: 45});
						FlxTween.tween(dad, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
						FlxTween.tween(black, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
						FlxTween.num(defaultCamZoom, defaultCamZoom + 0.2, (Conductor.stepCrochet / 1000) * 6, {}, function(newValue:Float)
						{
							defaultCamZoom = newValue;
						});
						makeInvisibleNotes(false);
					case 1040:
						defaultCamZoom = 0.8; 
						dad.alpha = 1;
						remove(black);
						FlxG.camera.flash();
				}
			case 'maze':
				switch (curStep)
				{
					case 466:
						defaultCamZoom += 0.2;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub1'), 0.02, 1);
					case 476:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub2'), 0.02, 0.7);
					case 484:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub3'), 0.02, 1);
					case 498:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub4'), 0.02, 1);
					case 510:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub5'), 0.02, 1, {subtitleSize: 60});
						makeInvisibleNotes(false);
					case 528:
						 defaultCamZoom = 0.8;
						black.alpha = 0;
						FlxG.camera.flash();
					case 832:
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.4}, 1);
					case 838:
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub6'), 0.02, 1);
					case 847:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub7'), 0.02, 0.5);
					case 856:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub8'), 0.02, 1);
					case 867:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub9'), 0.02, 1, {subtitleSize: 40});
					case 879:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub10'), 0.02, 1);
					case 890:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub11'), 0.02, 1);
					case 902:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub12'), 0.02, 1, {subtitleSize: 60});
						makeInvisibleNotes(false);
					case 908:
						FlxTween.tween(black, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
					case 912:
						if (!spotLightPart)
						{
							spotLightPart = true;
							defaultCamZoom -= 0.1;
							FlxG.camera.flash(FlxColor.WHITE, 0.5);
	
							spotLight = new FlxSprite().loadGraphic(Paths.image('spotLight'));
							spotLight.blend = BlendMode.ADD;
							spotLight.setGraphicSize(Std.int(spotLight.width * (dad.frameWidth / spotLight.width) * spotLightScaler));
							spotLight.updateHitbox();
							spotLight.alpha = 0;
							spotLight.origin.set(spotLight.origin.x,spotLight.origin.y - (spotLight.frameHeight / 2));
							add(spotLight);
	
							spotLight.setPosition(dad.getGraphicMidpoint().x - spotLight.width / 2, dad.getGraphicMidpoint().y + dad.frameHeight / 2 - (spotLight.height));	
							updateSpotlight(false);
							
							FlxTween.tween(black, {alpha: 0.6}, 1);
							FlxTween.tween(spotLight, {alpha: 0.7}, 1);
						}
					case 1168:
						spotLightPart = false;
						FlxTween.tween(spotLight, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
						{
							remove(spotLight);
						}});
						FlxTween.tween(black, {alpha: 0}, 1);
					case 1232:
						FlxG.camera.flash();
				}
			case 'greetings':
				switch (curStep)
				{
					case 492:
						var curZoom = defaultCamZoom;
						var time = (Conductor.stepCrochet / 1000) * 20;
						FlxG.camera.fade(FlxColor.WHITE, time, false, function()
						{
							FlxG.camera.fade(FlxColor.WHITE, 0, true, function()
							{
								FlxG.camera.flash(FlxColor.WHITE, 0.5);
							});
						});
						FlxTween.num(curZoom, curZoom + 0.4, time, {onComplete: function(tween:FlxTween)
						{
							defaultCamZoom = 0.7;
						}}, function(newValue:Float)
						{
							defaultCamZoom = newValue;
						});
				}
			case 'recursed':
				switch (curStep)
				{
					case 320:
						defaultCamZoom = 0.6;
						cinematicBars(((Conductor.stepCrochet * 30) / 1000), 400);
					case 352:
						defaultCamZoom = 0.4;
						FlxG.camera.flash();
					case 864:
						FlxG.camera.flash();
						charBackdrop.loadGraphic(Paths.image('recursed/bambiScroll'));
						freeplayBG.loadGraphic(bambiBG);
						freeplayBG.color = FlxColor.multiply(0xFF00B515, FlxColor.fromRGB(44, 44, 44));
						initAlphabet(bambiSongs);
					case 1248:
						defaultCamZoom = 0.6;
						FlxG.camera.flash();
						charBackdrop.loadGraphic(Paths.image('recursed/tristanScroll'));
						freeplayBG.loadGraphic(tristanBG);
						freeplayBG.color = FlxColor.multiply(0xFFFF0000, FlxColor.fromRGB(44, 44, 44));
						initAlphabet(tristanSongs);
					case 1632:
						defaultCamZoom = 0.4;
						FlxG.camera.flash();
				}
			case 'splitathon' | 'old-splitathon':
				switch (curStep)
				{
					case 4750:
						dad.canDance = false;
						dad.playAnim('scared', true);
						camHUD.shake(0.015, (Conductor.stepCrochet / 1000) * 50);
					case 4800:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						splitathonExpression('dave', 'what');
						addSplitathonChar("bambi-splitathon");
						if (!hasTriggeredDumbshit)
						{
							throwThatBitchInThere('bambi-splitathon', 'dave-splitathon');
						}
					case 5824:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						splitathonExpression('bambi', 'umWhatIsHappening');
						addSplitathonChar("dave-splitathon");
					case 6080:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						splitathonExpression('dave', 'happy'); 
						addSplitathonChar("bambi-splitathon");
					case 8384:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						splitathonExpression('bambi', 'yummyCornLol');
						addSplitathonChar("dave-splitathon");
					case 4799 | 5823 | 6079 | 8383:
						hasTriggeredDumbshit = false;
						updatevels = false;
				}

			case 'insanity' | 'insanity-2.5':
				switch (curStep)
				{
					case 384 | 1040:
						defaultCamZoom = 0.9;
					case 448 | 1056:
						defaultCamZoom = 0.8;
					case 512 | 768:
						defaultCamZoom = 1;
					case 640:
						defaultCamZoom = 1.1;
					case 660 | 680:
						FlxG.sound.play(Paths.sound('static'), 0.1);
						dad.visible = false;
						dadmirror.visible = true;
						curbg.visible = true;
						iconP2.changeIcon(dadmirror.curCharacter);
					case 664 | 684:
						dad.visible = true;
						dadmirror.visible = false;
						curbg.visible = false;
						iconP2.changeIcon(dad.curCharacter);
					case 708:
						defaultCamZoom = 0.8;
						dad.playAnim('um', true);

					case 1176:
						FlxG.sound.play(Paths.sound('static'), 0.1);
						dad.visible = false;
						dadmirror.visible = true;
						curbg.loadGraphic(Paths.image('backgrounds/void/redsky', 'shared'));
						if (isShaggy) curbg.y -= 200;
						curbg.alpha = 1;
						curbg.visible = true;
						iconP2.changeIcon(dadmirror.curCharacter);
					case 1180:
						dad.visible = true;
						dadmirror.visible = false;
						iconP2.changeIcon(dad.curCharacter);
						dad.canDance = false;
						dad.animation.play('scared', true);
				}
			case 'interdimensional':
				switch(curStep)
				{
					case 378:
						FlxG.camera.fade(FlxColor.WHITE, 0.3, false);
					case 384:
						black = new FlxSprite(0,0).makeGraphic(2560, 1440, FlxColor.BLACK);
						black.screenCenter();
						black.scrollFactor.set();
						black.alpha = 0.4;
						add(black);
						defaultCamZoom += 0.2;
						FlxG.camera.fade(FlxColor.WHITE, 0.5, true);
					case 512:
						defaultCamZoom -= 0.1;
					case 639:
						FlxG.camera.flash(FlxColor.WHITE, 0.3, false);
						defaultCamZoom -= 0.1; // pooop
						FlxTween.tween(black, {alpha: 0}, 0.5, 
						{
							onComplete: function(tween:FlxTween)
							{
								remove(black);
							}
						});
						changeInterdimensionBg('spike-void');
					case 1152:
						FlxG.camera.flash(FlxColor.WHITE, 0.3, false);
						changeInterdimensionBg('darkSpace');
						
						tweenList.push(FlxTween.color(gf, 1, gf.color, FlxColor.BLUE));
						tweenList.push(FlxTween.color(dad, 1, dad.color, FlxColor.BLUE));
						bfTween = FlxTween.color(boyfriend, 1, boyfriend.color, FlxColor.BLUE);
						flyingBgChars.forEach(function(char:FlyingBGChar)
						{
							tweenList.push(FlxTween.color(char, 1, char.color, FlxColor.BLUE));
						});
					case 1408:
						FlxG.camera.flash(FlxColor.WHITE, 0.3, false);
						changeInterdimensionBg('hexagon-void');

						tweenList.push(FlxTween.color(dad, 1, dad.color, FlxColor.WHITE));
						bfTween = FlxTween.color(boyfriend, 1, boyfriend.color, FlxColor.WHITE);
						tweenList.push(FlxTween.color(gf, 1, gf.color, FlxColor.WHITE));
						flyingBgChars.forEach(function(char:FlyingBGChar)
						{
							tweenList.push(FlxTween.color(char, 1, char.color, FlxColor.WHITE));
						});
					case 1792:
						FlxG.camera.flash(FlxColor.WHITE, 0.3, false);

						nimbiLand = new BGSprite('nimbiLand', 200, 100, Paths.image('backgrounds/void/interdimensions/nimbi/nimbi_land'), null, 1, 1, false, true);
						//backgroundSprites.add(nimbiLand);
						nimbiLand.setGraphicSize(Std.int(nimbiLand.width * 1.5));
						insert(members.indexOf(flyingBgChars), nimbiLand);
						add(nimbiLand);
		
						nimbiSign = new BGSprite('sign', 800, -73, Paths.image('backgrounds/void/interdimensions/nimbi/sign'), null, 1, 1, false, true);
						//backgroundSprites.add(nimbiSign);
						nimbiSign.setGraphicSize(Std.int(nimbiSign.width * 0.2));
						insert(members.indexOf(flyingBgChars), nimbiSign);
						add(nimbiSign);						

						nimbi = new BGSprite('train', 1250, 275, 'backgrounds/void/interdimensions/nimbi/nimbi', [
							new Animation('idle', 'lol hi dave and boyfriend fnf what a peculiar coincidence that we are here at this exact time', 24, true, [false, false])
						], 1, 1, true, true);
						nimbi.animation.play('idle');
						nimbi.updateHitbox();
						nimbi.setGraphicSize(Std.int(nimbi.width * 0.5));
						//nimbi.antialiasing = FlxG.save.data.globalAntialiasing;
						insert(members.indexOf(flyingBgChars), nimbi);
						add(nimbi);

						changeInterdimensionBg('nimbi-void');
					case 2176:
						FlxG.camera.flash(FlxColor.WHITE, 0.3, false);
						remove(nimbi);
						remove(nimbiSign);
						remove(nimbiLand);
						changeInterdimensionBg('interdimension-void');
					case 2688:
						defaultCamZoom = 0.7;
						for (bgSprite in backgroundSprites)
						{
							FlxTween.tween(bgSprite, {alpha: 0}, 1);
						}
						for (bgSprite in revertedBG)
						{
							FlxTween.tween(bgSprite, {alpha: 1}, 1);
						}

						canFloat = false;
						FlxG.camera.flash(FlxColor.WHITE, 0.25);
						switchDad('dave-festival', dad.getPosition(), false);

						regenerateStaticArrows(0);
						
						var color = getBackgroundColor(curStage);

						FlxTween.color(dad, 0.6, dad.color, color);
						if (formoverride != 'tristan-golden-glowing')
						{
							FlxTween.color(boyfriend, 0.6, boyfriend.color, color);
						}
						FlxTween.color(gf, 0.6, gf.color, color);

						FlxTween.linearMotion(dad, dad.x, dad.y, 100 + dad.globalOffset[0], 450 + dad.globalOffset[1], 0.6, true);
						if (isShaggy) {
							FlxTween.linearMotion(boyfriend, boyfriend.x, boyfriend.y, 770 + boyfriend.globalOffset[0], 450 + boyfriend.globalOffset[1], 0.6, true);
							shx = 770 + boyfriend.globalOffset[0];
							shy = 450 + boyfriend.globalOffset[1];
						}
						
						if (!isShaggy) {
							for (char in [boyfriend, gf])
							{
								if (char.animation.curAnim != null && char.animation.curAnim.name.startsWith('sing') && !char.animation.curAnim.finished)
								{
									char.animation.finishCallback = function(animation:String)
									{
										char.canDance = false;
										char == boyfriend ? char.playAnim('hey', true) : char.playAnim('cheer', true);
									}
								}
								else
								{
									char.canDance = false;
									char == boyfriend ? char.playAnim('hey', true) : char.playAnim('cheer', true);
								}
							}
						}
				}

			case 'unfairness':
				switch(curStep)
				{
					case 256:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 261:
						subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub1'), 0.02, 0.6);
					case 284:
					    subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub2'), 0.02, 0.6);
					case 321:
						subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub3'), 0.02, 0.6);
					case 353:
						subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub4'), 0.02, 1.5);
					case 414:
						subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub5'), 0.02, 0.6);
					case 439:
						subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub6'), 0.02, 1);
					case 468:
						subtitleManager.addSubtitle(LanguageManager.getTextString('unfairness_sub7'), 0.02, 1);
					case 512:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 2560:
						if (modchartoption) {
							dadStrums.forEach(function(spr:StrumNote)
							{
								FlxTween.tween(spr, {alpha: 0}, 6);
							});
						}
					case 2688:
						if (modchartoption) {
							playerStrums.forEach(function(spr:StrumNote)
							{
								FlxTween.tween(spr, {alpha: 0}, 6);
							});
						}
					case 3072:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						dad.visible = false;
						iconP2.visible = false;
				}

				case 'cheating-random':
					switch(curStep)
					{
						case 512:
							defaultCamZoom += 0.2;
							black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
							black.screenCenter();
							black.alpha = 0;
							add(black);
							FlxTween.tween(black, {alpha: 0.6}, 1);
							makeInvisibleNotes(true);
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub1'), 0.02, 0.6);
						case 537:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub2'), 0.02, 0.6);
						case 552:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub3'), 0.02, 0.6);
						case 570:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub4'), 0.02, 1);
						case 595:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub5'), 0.02, 0.6);
						case 607:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub6'), 0.02, 0.6);
						case 619:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub7'), 0.02, 1);
						case 640:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub8'), 0.02, 0.6);
						case 649:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub9'), 0.02, 0.6);
						case 654:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub10'), 0.02, 0.6);
						case 666:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub11'), 0.02, 0.6);
						case 675:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub12'), 0.02, 0.6);
						case 685:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub13'), 0.02, 0.6);
						case 695:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub14'), 0.02, 0.6);
						case 712:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub15'), 0.02, 0.6);
						case 715:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub16'), 0.02, 0.6);
						case 722:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub17'), 0.02, 0.6);
						case 745:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub18'), 0.02, 0.3);
						case 749:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub19'), 0.02, 0.3);
						case 756:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub20'), 0.02, 0.6);
						case 768:
							defaultCamZoom -= 0.2;
							FlxTween.tween(black, {alpha: 0}, 1);
							makeInvisibleNotes(false);
						case 1280:
							defaultCamZoom += 0.2;
							black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
							black.screenCenter();
							black.alpha = 0;
							add(black);
							FlxTween.tween(black, {alpha: 0.6}, 1);
						case 1301:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub21'), 0.02, 0.6);
						case 1316:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub22'), 0.02, 0.6);
						case 1344:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub23'), 0.02, 0.6);
						case 1374:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub24'), 0.02, 1);
						case 1394:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub25'), 0.02, 0.5);
						case 1403:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub26'), 0.02, 1);
						case 1429:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub27'), 0.02, 0.6);
						case 1475:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub28'), 0.02, 1.5);
						case 1504:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub29'), 0.02, 1);
						case 1528:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub30'), 0.02, 0.6);
						case 1536:
							defaultCamZoom -= 0.2;
							FlxTween.tween(black, {alpha: 0}, 1);

					}
				case 'cheating':
					switch(curStep)
					{
						case 512:
							defaultCamZoom += 0.2;
							black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
							black.screenCenter();
							black.alpha = 0;
							add(black);
							FlxTween.tween(black, {alpha: 0.6}, 1);
							makeInvisibleNotes(true);
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub1'), 0.02, 0.6);
						case 537:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub2'), 0.02, 0.6);
						case 552:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub3'), 0.02, 0.6);
						case 570:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub4'), 0.02, 1);
						case 595:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub5'), 0.02, 0.6);
						case 607:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub6'), 0.02, 0.6);
						case 619:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub7'), 0.02, 1);
						case 640:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub8'), 0.02, 0.6);
						case 649:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub9'), 0.02, 0.6);
						case 654:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub10'), 0.02, 0.6);
						case 666:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub11'), 0.02, 0.6);
						case 675:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub12'), 0.02, 0.6);
						case 685:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub13'), 0.02, 0.6);
						case 695:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub14'), 0.02, 0.6);
						case 712:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub15'), 0.02, 0.6);
						case 715:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub16'), 0.02, 0.6);
						case 722:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub17'), 0.02, 0.6);
						case 745:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub18'), 0.02, 0.3);
						case 749:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub19'), 0.02, 0.3);
						case 756:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub20'), 0.02, 0.6);
						case 768:
							defaultCamZoom -= 0.2;
							FlxTween.tween(black, {alpha: 0}, 1);
							makeInvisibleNotes(false);
						case 1280:
							defaultCamZoom += 0.2;
							black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
							black.screenCenter();
							black.alpha = 0;
							add(black);
							FlxTween.tween(black, {alpha: 0.6}, 1);
						case 1301:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub21'), 0.02, 0.6);
						case 1316:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub22'), 0.02, 0.6);
						case 1344:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub23'), 0.02, 0.6);
						case 1374:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub24'), 0.02, 1);
						case 1394:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub25'), 0.02, 0.5);
						case 1403:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub26'), 0.02, 1);
						case 1429:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub27'), 0.02, 0.6);
						case 1475:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub28'), 0.02, 1.5);
						case 1504:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub29'), 0.02, 1);
						case 1528:
							subtitleManager.addSubtitle(LanguageManager.getTextString('cheating_sub30'), 0.02, 0.6);
						case 1536:
							defaultCamZoom -= 0.2;
							FlxTween.tween(black, {alpha: 0}, 1);

					}

			case 'polygonized' | 'polygonized-2.5':
				switch(curStep)
				{
					case 128 | 640 | 704 | 1535:
						defaultCamZoom = 0.9;
					case 256 | 768 | 1468 | 1596 | 2048 | 2144 | 2428:
						defaultCamZoom = 0.7;
					case 688 | 752 | 1279 | 1663 | 2176:
						defaultCamZoom = 1;
					case 1019 | 1471 | 1599 | 2064:
						defaultCamZoom = 0.8;
					case 1920:
						defaultCamZoom = 1.1;

					case 1024 | 1312:
						defaultCamZoom = 1.1;
						crazyZooming = true;

						if (localFunny != CharacterFunnyEffect.Recurser)
						{
							shakeCam = true;
							pre3dSkin = boyfriend.curCharacter;
							for (char in [boyfriend, gf])
							{
								if (char.skins.exists('3d'))
								{
									if (char == boyfriend)
									{
										switchBF(char.skins.get('3d'), char.getPosition());
									}
									else if (char == gf)
									{
										switchGF(char.skins.get('3d'), char.getPosition());
									}
								}
							}
						}
					case 1152 | 1408:
						defaultCamZoom = 0.9;
						shakeCam = false;
						crazyZooming = false;
						if (localFunny != CharacterFunnyEffect.Recurser)
						{
							if (boyfriend.curCharacter != pre3dSkin)
							{
								switchBF(pre3dSkin, boyfriend.getPosition());
								switchGF(boyfriend.skins.get('gfSkin'), gf.getPosition());
							}
						}
				}
					
			case 'adventure':
				switch (curStep)
				{
					case 1151:
						defaultCamZoom = 1;
					case 1407:
						defaultCamZoom = 0.8;	
				}
			case 'glitch':
				switch (curStep)
				{
					case 15:
						dad.playAnim('hey', true);
					case 16 | 719 | 1167:
						defaultCamZoom = 1;
					case 80 | 335 | 588 | 1103:
						defaultCamZoom = 0.8;
					case 584 | 1039:
						defaultCamZoom = 1.2;
					case 272 | 975:
						defaultCamZoom = 1.1;
					case 464:
						defaultCamZoom = 1;
						FlxTween.linearMotion(dad, dad.x, dad.y, 25, 50, 20, true);
					case 848:
						shakeCam = false;
						crazyZooming = false;
						defaultCamZoom = 1;
					case 132 | 612 | 740 | 771 | 836:
						shakeCam = true;
						crazyZooming = true;
						defaultCamZoom = 1.2;
					case 144 | 624 | 752 | 784:
						shakeCam = false;
						crazyZooming = false;
						defaultCamZoom = 0.8;
					case 1231:
						defaultCamZoom = 0.8;
						FlxTween.linearMotion(dad, dad.x, dad.y, 50, 280, 1, true);
				}
			case 'mealie':
				switch (curStep)
				{
					case 659:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub1'), 0.02, 0.6);
					case 1183:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 1193:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub2'), 0.02, 0.6);
					case 1208:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub3'), 0.02, 1.5);
					case 1228:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub4'), 0.02, 1);
					case 1242:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub5'), 0.02, 1);
					case 1257:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub6'), 0.02, 0.5);
					case 1266:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub7'), 0.02, 1.5);
					case 1289:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub8'), 0.02, 2);
					case 1344:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 1584:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub15'), 0.02, 1);
					case 1746:
					case 1751:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub9'), 0.02, 0.6);
					case 1770:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub10'), 0.02, 0.6);
					case 1776:
						FlxG.camera.flash(FlxColor.WHITE, 0.25);
						switchDad(FlxG.random.int(0, 999) == 0 ? 'bambi-angey-old' : 'bambi-angey', dad.getPosition());
						dad.color = nightColor;
					case 1800:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub11'), 0.02, 0.6);
					case 1810:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub12'), 0.02, 0.6);
					case 1843:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub13'), 0.02, 1, {subtitleSize: 60});
					case 2418:
						subtitleManager.addSubtitle(LanguageManager.getTextString('mealie_sub14'), 0.02, 0.6);				
				}
			case 'indignancy':
				switch (curStep)
				{
					case 128:
						FlxTween.tween(vignette, {alpha: 0}, 1);
					case 124 | 304 | 496 | 502 | 576 | 848:
						defaultCamZoom += 0.2;
					case 176:
						defaultCamZoom -= 0.2;
						crazyZooming = true;
					case 320 | 832 | 864:
						defaultCamZoom -= 0.2;
					case 508:
						defaultCamZoom -= 0.4;		
					case 320 | 864:
						crazyZooming = true;	
					case 304 | 832 | 1088 | 2144:
						crazyZooming = false;
					case 1216:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 1217:
						subtitleManager.addSubtitle(LanguageManager.getTextString('indignancy_sub1'), 0.02, 2);
					case 1262:
						subtitleManager.addSubtitle(LanguageManager.getTextString('indignancy_sub2'), 0.02, 1.5);
					case 1292:
						subtitleManager.addSubtitle(LanguageManager.getTextString('indignancy_sub3'), 0.02, 1);
					case 1330:
						subtitleManager.addSubtitle(LanguageManager.getTextString('indignancy_sub4'), 0.02, 0.5);
				    case 1344:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 1622:
						subtitleManager.addSubtitle(LanguageManager.getTextString('indignancy_sub5'), 0.02, 0.3);
						
						defaultCamZoom += 0.4;
						FlxG.camera.shake(0.015, 0.6);
						dad.canDance = false;
						dad.playAnim('scream', true);
						dad.animation.finishCallback = function(animation:String)
						{
							dad.canDance = true;
						}
					case 1632:
						defaultCamZoom -= 0.4;
						crazyZooming = true;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
				}
				switch (curBeat)
				{
					case 335:
						if (!spotLightPart)
						{
							spotLightPart = true;
							FlxG.camera.flash(FlxColor.WHITE, 0.5);
	
							spotLight = new FlxSprite().loadGraphic(Paths.image('spotLight'));
							spotLight.blend = BlendMode.ADD;
							spotLight.setGraphicSize(Std.int(spotLight.width * (dad.frameWidth / spotLight.width) * spotLightScaler));
							spotLight.updateHitbox();
							spotLight.alpha = 0;
							spotLight.origin.set(spotLight.origin.x,spotLight.origin.y - (spotLight.frameHeight / 2));
							add(spotLight);
	
							spotLight.setPosition(dad.getGraphicMidpoint().x - spotLight.width / 2, dad.getGraphicMidpoint().y + dad.frameHeight / 2 - (spotLight.height));
	
							updateSpotlight(false);
							
							FlxTween.tween(black, {alpha: 0.6}, 1);
							FlxTween.tween(spotLight, {alpha: 1}, 1);
						}
					case 408:
						spotLightPart = false;
						FlxTween.tween(spotLight, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
						{
							remove(spotLight);
						}});
						FlxTween.tween(black, {alpha: 0}, 1);
				}
			case 'exploitation':
				switch(curStep)
				{
					case 12, 18, 23:
						blackScreen.alpha = 1;
						FlxTween.tween(blackScreen, {alpha: 0}, Conductor.crochet / 1000);
						FlxG.sound.play(Paths.sound('static'), 0.5);

						creditsPopup.switchHeading({path: 'songHeadings/glitchHeading', antiAliasing: false, animation: 
						new Animation('glitch', 'glitchHeading', 24, true, [false, false]), iconOffset: 0});
						
						creditsPopup.changeText('', 'none', false);
					case 20:
						creditsPopup.switchHeading({path: 'songHeadings/expungedHeading', antiAliasing: true,
						animation: new Animation('expunged', 'Expunged', 24, true, [false, false]), iconOffset: 0});

						creditsPopup.changeText('Song by Oxygen', 'Oxygen');
					case 14, 24:
						creditsPopup.switchHeading({path: 'songHeadings/expungedHeading', antiAliasing: true,
						animation: new Animation('expunged', 'Expunged', 24, true, [false, false]), iconOffset: 0});

						creditsPopup.changeText('Song by EXPUNGED', 'whoAreYou');
					case 32 | 512:
						FlxTween.tween(boyfriend, {alpha: 0}, 3);
						FlxTween.tween(gf, {alpha: 0}, 3);
						defaultCamZoom = FlxG.camera.zoom + 0.3;
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 4);
					case 128 | 576:
						defaultCamZoom = FlxG.camera.zoom - 0.3;
						FlxTween.tween(boyfriend, {alpha: 1}, 0.2);
						FlxTween.tween(gf, {alpha: 1}, 0.2);
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom - 0.3}, 0.05);
						mcStarted = true;

					case 184 | 824:
						FlxTween.tween(FlxG.camera, {angle: 10}, 0.1);
					case 188 | 828:
						FlxTween.tween(FlxG.camera, {angle: -10}, 0.1);
					case 192 | 832:
						FlxTween.tween(FlxG.camera, {angle: 0}, 0.2);
					case 1276:
						FlxG.camera.fade(FlxColor.WHITE, (Conductor.stepCrochet / 1000) * 4, false, function()
						{
							FlxG.camera.stopFX();
						});
						FlxG.camera.shake(0.015, (Conductor.stepCrochet / 1000) * 4);
					case 1280:
						shakeCam = true;
						FlxG.camera.zoom -= 0.2;

						windowProperties = [
							Application.current.window.x,
							Application.current.window.y,
							Application.current.window.width,
							Application.current.window.height
						];

						#if windows
						if (modchartoption) popupWindow();
						#end
						
						modchart = ExploitationModchartType.Figure8;
						if (modchartoption) {
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
						}

					case 1282:
						expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/broken_expunged_chain', 'shared'));
						expungedBG.setGraphicSize(Std.int(expungedBG.width * 2));
					case 1311:
						shakeCam = false;
						FlxG.camera.zoom += 0.2;	
					case 1343:
						shakeCam = true;
						FlxG.camera.zoom -= 0.2;	
					case 1375:
						shakeCam = false;
						FlxG.camera.zoom += 0.2;
					case 1487:
						shakeCam = true;
						FlxG.camera.zoom -= 0.2;
					case 1503:
						shakeCam = false;
						FlxG.camera.zoom += 0.2;
					case 1536:						
						expungedBG.loadGraphic(Paths.image('backgrounds/void/exploit/creepyRoom', 'shared'));
						expungedBG.setGraphicSize(Std.int(expungedBG.width * 2));
						expungedBG.setPosition(0, 200);
						
						modchart = ExploitationModchartType.Sex;
						if (modchartoption) {
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
						}
					case 2080:
						#if windows
						if (window != null)
						{
							window.close();
							expungedWindowMode = false;
							window = null;
							FlxTween.tween(Application.current.window, {x: windowProperties[0], y: windowProperties[1], width: windowProperties[2], height: windowProperties[3]}, 1, {ease: FlxEase.circInOut});
							FlxTween.tween(iconP2, {alpha: 0}, 1, {ease: FlxEase.bounceOut});
						}
						#end
					case 2083:
						PlatformUtil.sendWindowsNotification("Anticheat.dll", "Threat expunged.dat successfully contained.");
				}
			case 'shredder':
				switch (curStep)
				{
					case 261:
						defaultCamZoom += 0.2;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.scrollFactor.set();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub1'), 0.02, 0.3);
					case 273:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub2'), 0.02, 0.6);
					case 296:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub3'), 0.02, 0.6);
					case 325:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub4'), 0.02, 0.6);
					case 342:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub5'), 0.02, 0.6);
					case 356:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub6'), 0.02, 0.6);
					case 361:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub7'), 0.02, 0.6);
					case 384:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub8'), 0.02, 0.6, {subtitleSize: 60});
					case 393:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub9'), 0.02, 0.6, {subtitleSize: 60});
					case 408:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub10'), 0.02, 0.6, {subtitleSize: 60});
					case 425:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub11'), 0.02, 0.6, {subtitleSize: 60});
					case 484:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub12'), 0.02, 0.6, {subtitleSize: 60});
					case 512:
						defaultCamZoom -= 0.2;
						FlxG.camera.flash();
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 784 | 816 | 912 | 944:
						#if SHADERS_ENABLED
						camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
						#end
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 800 | 832 | 928:
						camHUD.setFilters([]);
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
					case 960:
						camHUD.setFilters([]);
						defaultCamZoom = 0.7;
						FlxTween.tween(black, {alpha: 0}, 1);
					case 992:
						dadStrums.forEach(function(spr:StrumNote)
						{
							FlxTween.tween(spr, {alpha: 0}, 1);
						});
					case 1008:
						switchDad('bambi-shredder', dad.getPosition());
						dad.playAnim('takeOut', true);

					case 1024:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);

						playerStrums.forEach(function(spr:StrumNote)
						{
							FlxTween.cancelTweensOf(spr);
						});

						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.alpha = 1;
						});
						
						lockCam = true;
						
						originalBFScale = boyfriend.scale.copyTo(originalBFScale);
						originBFPos = boyfriend.getPosition();
						originBambiPos = dad.getPosition();

						dad.cameras = [camHUD];
						dad.scale.set(dad.scale.x * 0.55, dad.scale.y * 0.55);
						dad.updateHitbox();
						dad.offsetScale = 0.55;
						dad.scrollFactor.set();
						dad.setPosition(-21, -10);

						bambiSpot = new FlxSprite(34, 151).loadGraphic(Paths.image('festival/shredder/bambi_spot'));
						bambiSpot.scrollFactor.set();
						bambiSpot.blend = BlendMode.ADD;
						bambiSpot.cameras = [camHUD];
						insert(members.indexOf(dadGroup), bambiSpot);

						bfSpot = new FlxSprite(995, 381).loadGraphic(Paths.image('festival/shredder/boyfriend_spot'));
						bfSpot.scrollFactor.set();
						bfSpot.blend = BlendMode.ADD;
						bfSpot.cameras = [camHUD];
						bfSpot.alpha = 0;

						boyfriend.cameras = [camHUD];
						boyfriend.scale.set(boyfriend.scale.x * 0.45, boyfriend.scale.y * 0.45);
						boyfriend.updateHitbox();
						boyfriend.offsetScale = 0.45;
						boyfriend.scrollFactor.set();
						boyfriend.setPosition((bfSpot.x - (boyfriend.width / 3.25)) + boyfriend.globalOffset[0] * boyfriend.offsetScale, (bfSpot.y - (boyfriend.height * 1.1)) + boyfriend.globalOffset[1] * boyfriend.offsetScale);
						if (isShaggy) boyfriend.y += 100;
						shx = (bfSpot.x - (boyfriend.width / 3.25)) + boyfriend.globalOffset[0] * boyfriend.offsetScale;
						shy = (bfSpot.y - (boyfriend.height * 1.1)) + boyfriend.globalOffset[1] * boyfriend.offsetScale;
						boyfriend.alpha = 0;

						insert(members.indexOf(bfGroup), bfSpot);

						highway = new FlxSprite().loadGraphic(Paths.image('festival/shredder/ch_highway'));
						highway.setGraphicSize(Std.int(highway.width * (670 / highway.width)), Std.int(highway.height * (1340 / highway.height)));
						highway.updateHitbox();
						highway.cameras = [camHUD];
						highway.screenCenter();
						highway.scrollFactor.set();
						insert(members.indexOf(strumLineNotes), highway);

						black = new FlxSprite().makeGraphic(2560, 1440, FlxColor.BLACK);
						black.screenCenter();
						black.scrollFactor.set();
						black.alpha = 0.9;
						insert(members.indexOf(highway), black);

						dadStrums.forEach(function(spr:StrumNote)
						{
							dadStrums.remove(spr);
							strumLineNotes.remove(spr);
							remove(spr);
						});
						generateGhNotes(0);
						
						dadStrums.forEach(function(spr:StrumNote)
						{
							spr.centerStrum();
							spr.x -= (spr.width / 4);
						});
						playerStrums.forEach(function(spr:StrumNote)
						{
							spr.centerStrum();
							spr.alpha = 0;
							spr.x -= (noteWidth / 4);
						});
					case 1276:
						dadStrums.forEach(function(spr:StrumNote)
						{
							FlxTween.tween(spr, {alpha: 0}, (Conductor.stepCrochet / 1000) * 2);
						});
						playerStrums.forEach(function(spr:StrumNote)
						{
							FlxTween.tween(spr, {alpha: 1}, (Conductor.stepCrochet / 1000) * 2);
						});
					case 1280:
						FlxTween.tween(boyfriend, {alpha: 1}, 1);
						FlxTween.tween(bfSpot, {alpha: 1}, 1);
					case 1536:
						var blackFront = new FlxSprite(0, 0).makeGraphic(2560, 1440, FlxColor.BLACK);
						blackFront.screenCenter();
						blackFront.alpha = 0;
						blackFront.cameras = [camHUD];
						add(blackFront);
						FlxTween.tween(blackFront, {alpha: 1}, 0.5, {onComplete: function(tween:FlxTween)
						{
							lockCam = false;
							strumLineNotes.forEach(function(spr:StrumNote)
							{
								spr.x = spr.baseX;
							});
							switchDad('bambi-new', originBambiPos, false);

							boyfriend.cameras = dad.cameras;
							boyfriend.scale.set(originalBFScale.x, originalBFScale.y);
							boyfriend.updateHitbox();
							boyfriend.offsetScale = 1;
							boyfriend.scrollFactor.set(1, 1);
							boyfriend.setPosition(originBFPos.x, originBFPos.y);
							shx = originBFPos.x;
							shy = originBFPos.y;
								
							for (hudElement in [black, blackFront, bambiSpot, bfSpot, highway])
							{
								remove(hudElement);
							}
							FlxTween.tween(blackFront, {alpha: 0}, 0.5);
						}});
						regenerateStaticArrows(0);

						defaultCamZoom += 0.2;
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
						{
							camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
						}
						#end
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 1552:
						camHUD.setFilters([]);
						defaultCamZoom += 0.1;
					case 1568:
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
							{
								camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
							}
						#end
						defaultCamZoom += 0.1;
					case 1584:
						camHUD.setFilters([]);
						defaultCamZoom += 0.1;
					case 1600:
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
							{
								camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
							}
						#end
						defaultCamZoom += 0.1;
					case 1616:
						camHUD.setFilters([]);
						defaultCamZoom += 0.1;
					case 1632:
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
							{
								camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
							}
						#end
						defaultCamZoom += 0.1;
					case 1648:
						FlxTween.tween(black, {alpha: 1}, 1);
						camHUD.setFilters([]);
						defaultCamZoom += 0.1;
					case 1664:
						defaultCamZoom -= 0.9;
						FlxG.camera.flash();
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 1937:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub13'), 0.02, 0.6, {subtitleSize: 60});
					case 1946:
						subtitleManager.addSubtitle(LanguageManager.getTextString('shred_sub14'), 0.02, 0.6, {subtitleSize: 60});
				}
			case 'rano':
				switch (curStep)
				{
					case 512:
						defaultCamZoom = 0.9;
					case 640:
						defaultCamZoom = 0.7;
					case 1792:
						dad.canDance = false;
						dad.canSing = false;
						dad.playAnim('sleepIdle', true);
						dad.animation.finishCallback = function(anim:String)
						{
							dad.playAnim('sleeping', true);
						}
				}
			case 'five-nights':
				if (!powerRanOut)
				{
					switch (curStep)
					{
						case 60:
							switchNoteSide();
						case 64 | 320 | 480 | 576 | 704 | 832 | 1024:
							nofriendAttack();
						case 992:
							defaultCamZoom = 1.2;
							FlxTween.tween(camHUD, {alpha: 0}, 1);
						case 1088:
							sixAM();
					}
				}
			case 'bot-trot':
				switch (curStep)
				{
					case 896:
						FlxG.camera.flash();
						FlxG.sound.play(Paths.sound('lightswitch'), 1);
						defaultCamZoom = 1.1;
						switchToNight();
					case 1151:
						defaultCamZoom = 0.8;
				}
			case 'supernovae' | 'old-supernovae':
				switch (curStep)
				{
					case 60:
						dad.playAnim('hey', true);
					case 64:
						defaultCamZoom = 1;
					case 192:
						defaultCamZoom = 0.9;
					case 320 | 768:
						defaultCamZoom = 1.1;
					case 444:
						defaultCamZoom = 0.6;
					case 448 | 960 | 1344:
						defaultCamZoom = 0.8;
					case 896 | 1152:
						defaultCamZoom = 1.2;
					case 1024:
						defaultCamZoom = 1;
						shakeCam = true;
						FlxTween.linearMotion(dad, dad.x, dad.y, 25, 50, 15, true);

					case 1280:
						FlxTween.linearMotion(dad, dad.x, dad.y, 50, 280, 0.6, true);
						shakeCam = false;
						defaultCamZoom = 1;
				}
			case 'master':
				switch (curStep)
				{
					case 128:
						defaultCamZoom = 0.7;
					case 252 | 512:
						defaultCamZoom = 0.4;
						shakeCam = false;
					case 256:
						defaultCamZoom = 0.8;
					case 380:
						defaultCamZoom = 0.5;
					case 384:
						defaultCamZoom = 1;
						shakeCam = true;
					case 508:
						defaultCamZoom = 1.2;
					case 560:
						dad.playAnim('die', true);			
						FlxG.sound.play(Paths.sound('dead'), 1);
					}
			case 'vs-dave-rap':
				switch(curStep)
				{
						case 64:
							FlxG.camera.flash();
						case 68:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub1'), 0.02, 1);
						case 92:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub2'), 0.02, 0.8);
						case 112:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub3'), 0.02, 0.8);
						case 124:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub4'), 0.02, 0.5);
						case 140:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub5'), 0.02, 0.5);
						case 150:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub6'), 0.02, 1);
						case 176:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub7'), 0.02, 0.5);
						case 184:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub8'), 0.02, 0.8);
						case 201:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub9'), 0.02, 0.5);
						case 211:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub10'), 0.02, 0.8);
						case 229:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub11'), 0.02, 0.5);
						case 241:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub12'), 0.02, 0.8);
						case 260:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub13'), 0.02, 0.8);
						case 281:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub14'), 0.02, 0.5);
						case 288:
							subtitleManager.addSubtitle(LanguageManager.getTextString('daverap_sub15'), 0.02, 1.5);
						case 322:
							FlxG.camera.flash();
					}
		    case 'vs-dave-rap-two':
				switch(curStep)
			    {
					case 62:
						FlxG.camera.flash();
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub1'), 0.02, 0.5);
					case 79:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub2'), 0.02, 0.3);
					case 88:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub3'), 0.02, 1.5);
					case 112:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub4'), 0.02, 1.5);
					case 140:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub5'), 0.02, 1);
					case 168:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub6'), 0.02, 0.7);
					case 179:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub7'), 0.02, 0.7);
					case 194:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub8'), 0.02, 1.5);
					case 222:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub9'), 0.02, 2);
					case 256:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub10'), 0.02, 2);	
					case 291:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub11'), 0.02, 1);
					case 342:
						subtitleManager.addSubtitle(LanguageManager.getTextString('daveraptwo_sub12'), 0.02, 1);
					case 351:
						FlxG.camera.flash();
				}
			case 'memory':
				switch (curStep)
				{
					case 1408:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 1422:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub1'), 0.02, 0.5);
					case 1436:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub2'), 0.02, 1);
					case 1458:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub3'), 0.02, 0.7);
					case 1476:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub4'), 0.02, 1);
					case 1508:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub5'), 0.02, 1.5);
					case 1541:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub6'), 0.02, 1);
					case 1561:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub7'), 0.02, 1);
					case 1583:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub8'), 0.02, 0.8);
					case 1608:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub9'), 0.02, 1);
					case 1632:
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub10'), 0.02, 0.5);
					case 1646:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('memory_sub11'), 0.02, 1);
					case 1664:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
				}
			case 'bananacore':
				switch (curStep)
				{
					case 160 | 436 | 684:
						gfSpeed = 2;
					case 240:
						gfSpeed = 1;
					case 480:
						//swapDad("bartholemew");
						switchDad('bartholemew', dad.getPosition(), false);
					case 512:
						switchDad('older-cockey', dad.getPosition(), false);
					case 768:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid2'));
					case 822:
						trace("Phase 2");
						sexDad = new Character(dad.x - 700, dad.y, "older-cockey");
						add(sexDad);
						dad.alpha = 0;
					case 842:
						switchDad('old-pissey', dad.getPosition(), false);
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 5);
					case 1530:
						shag = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/shaggy from fnf 1", 'shared'));
						shag.screenCenter();
						shag.alpha = 0;
						add(shag);
						trace("Shaggy Fade In");
						FlxTween.tween(shag, {alpha: 1}, 3);
					case 1550:
						remove(shag);
					case 1643:
						for (sprite in cuzsieKapiEletricCockadoodledoo)
						{
							sprite.visible = true;
						}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						switchDad('cuzsiee', dad.getPosition(), false);
						switchBF('kapi', boyfriend.getPosition(), false);
	
						trace("Kapi BG");
	
						defaultCamZoom += 0.2;
					case 1664:
						for (sprite in cuzsieKapiEletricCockadoodledoo)
						{
							sprite.visible = false;
						}
						switchDad('old-pissey', dad.getPosition(), false);
						switchBF('bf', boyfriend.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
	
						trace("Reset Kapi BG");
	
						defaultCamZoom -= 0.2;
					case 1858:
						trace("BF Float");
						FlxTween.tween(boyfriend, {y: boyfriend.y - 700}, 8);
					case 1985:
						boyfriend.y = boyfriend.y + 700;
						FlxG.camera.flash(FlxColor.WHITE, 1);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid3'));
						trace("Phase 3");
					case 2112:
						FlxG.camera.flash(FlxColor.WHITE, 0.25);
						dad.visible = false;
						sexDad.visible = false;
					case 2201:
						switchDad('bambi-unfair-old', dad.getPosition(), false);	
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 0.5);
					case 2624:
						indihome = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/indihome", 'shared'));
						indihome.screenCenter();
						indihome.cameras = [camHUD];
						indihome.antialiasing = FlxG.save.data.globalAntialiasing;
						add(indihome);
						trace("Indihome");
					case 2688:
						remove(indihome);
					case 2818 | 2945:
						switchDad('bambi-new', dad.getPosition(), false);
					case 2848 | 2945:
						switchDad('bambi-unfair-old', dad.getPosition(), false);
					case 2875:
						switchDad('ayo-the-pizza-here', dad.getPosition(), false);
	
						dad.playAnim('pizza');
	
						trace("Ayo the pizza here");
					case 2880:
						switchDad('bambi-unfair-old', dad.getPosition(), false);
					case 2911:
						switchDad('bambi-unfair-old', dad.getPosition(), false);
					case 2912:
						switchDad('expunged', dad.getPosition(), false);
					case 2988:
						switchDad('ayo-the-pizza-here', dad.getPosition(), false);
	
						dad.playAnim('pizza');
	
						trace("Ayo the pizza here");
					case 3008:
						switchDad('bambi-unfair-old', dad.getPosition(), false);
					case 2201:	
						switchDad('bambi-unfair-old', dad.getPosition(), false);
						dad.alpha = 0;
					case 3200:
						// re-using indihome bc im lazy as fuck
						indihome = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/muffin", 'shared'));
						indihome.antialiasing = FlxG.save.data.globalAntialiasing;
						indihome.screenCenter();
						indihome.cameras = [camHUD];
						add(indihome);
	
						trace("EGG McMuffin");
					case 3328:
						remove(indihome);
						camHUD.visible = false;
						boyfriend.playAnim("firstDeath");
						boyfriend.canDance = false;
	
						trace("Death Animation");
					case 3360:
						boyfriend.playAnim("deathLoop");
	
						trace("Death Loop");
					case 3392:
						camHUD.visible = true;
						boyfriend.playAnim("idle");
						boyfriend.canDance = true;
					case 3696:
						hideStuff = new FlxSprite().makeGraphic(2560, 1440, FlxColor.BLACK);
						hideStuff.screenCenter();
						add(hideStuff);
						camHUD.visible = false;
					case 3728:
						camHUD.visible = true;
						camHUD.alpha = 0;
	
						dadStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0;
						});
	
						FlxTween.tween(camHUD, {alpha: 1}, 3);
					case 3568:
						FlxTween.tween(dad, {alpha: 0}, 6);
					case 3685:
						jumpscare.frames = Paths.getSparrowAtlas('fiveNights/nofriendJumpscare', 'shared');
						jumpscare.animation.addByPrefix('scare', 'jumpscare', 24, false);
						jumpscare.setGraphicSize(FlxG.width * 2, FlxG.height * 2);
						jumpscare.updateHitbox();
						jumpscare.screenCenter();
						jumpscare.scrollFactor.set();
						jumpscare.animation.play('scare');
						jumpscare.antialiasing = FlxG.save.data.globalAntialiasing;
						add(jumpscare);
					case 3696:
						staticBG.frames = Paths.getSparrowAtlas('fiveNights/deathStatic', 'shared');
						staticBG.animation.addByPrefix('static', 'static', 24, true);
						staticBG.setGraphicSize(FlxG.width * 2, FlxG.height * 2);
						staticBG.updateHitbox();
						staticBG.screenCenter();
						staticBG.antialiasing = FlxG.save.data.globalAntialiasing;
						staticBG.scrollFactor.set();
						staticBG.animation.play('static');
						add(staticBG);
					case 3750:
						remove(staticBG);
						remove(jumpscare);	
				}
	
				// Vinebooms
				for (trigger in vineBoomTriggers)
				{
				if (curStep == trigger)
				{
					FlxG.camera.flash(FlxColor.WHITE, 0.25);
					var sadBamb:FlxSprite = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/sad_bambi", 'shared'));
					sadBamb.antialiasing = FlxG.save.data.globalAntialiasing;
					sadBamb.screenCenter();
					sadBamb.cameras = [camHUD];
					add(sadBamb);
	
					FlxTween.tween(sadBamb, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
					{
						remove(sadBamb);
					}});
					}
				}
			case 'electric-cockaldoodledoo':
				switch (curStep)
				{
					//Cockey
					case 127:
						dad.alpha = 1;
						FlxG.camera.zoom += 0.5;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
					case 150:
						black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub1'), 0.02, 1);
					case 238:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub2'), 0.02, 1);
					case 255:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						FlxTween.tween(black, {alpha: 0}, 1);
					case 486:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub3'), 0.02, 1);
					case 492:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub3.1'), 0.02, 1);
					case 499:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub3.2'), 0.02, 1);
					case 507:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub3.3'), 0.02, 1);
					case 512:
						FlxTween.tween(black, {alpha: 0}, 1);
					case 649:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub4'), 0.02, 1);
					case 673:
						FlxTween.tween(black, {alpha: 0}, 1);
					case 832:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid2'));
						trace("Phase 2");
						sexDad = new Character(dad.x - 1000, dad.y, "cockey");
						add(sexDad);
						dad.alpha = 0;
					//Pissey
					case 842:
						switchDad('pissey', dad.getPosition(), false);
						dad.alpha = 0;
						dad.playAnim('phoneOFF');
						FlxTween.tween(dad, {alpha: 1}, 5);
					case 920:
						dad.playAnim('phoneAWAY');
					case 1311:
						FlxTween.tween(weirdBG, {alpha: 0}, 5);	
					case 1695:
						defaultCamZoom += 0.2;
					case 1823:
						defaultCamZoom -= 0.2;
						weirdBG.alpha = 1;
					case 1855:
						for (sprite in cuzsieKapiEletricCockadoodledoo)
						{
							sprite.visible = true;
						}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						switchDad('cuzsiee', dad.getPosition(), false);
						switchBF('kapi', boyfriend.getPosition(), false);
	
						trace("Kapi BG");
		
						defaultCamZoom += 0.2;
					//Shartey
					case 1919:
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid2.5'));
						FlxG.camera.flash(FlxColor.WHITE, 1);
						for (sprite in cuzsieKapiEletricCockadoodledoo)
						{
							sprite.visible = false;
						}
						switchDad('shartey', dad.getPosition(), false);
						switchBF('bf', boyfriend.getPosition(), false);
	
						trace("Reset Kapi BG");
	
						defaultCamZoom -= 0.2;
						FlxG.camera.zoom += 1;
					/*case 1920:
						curECCCharacter = "shartey";
						remove(dad);
						dad = new Character(dad.x, dad.y, curECCCharacter, false);
						add(dad);
						iconP2.changeIcon(curECCCharacter);*/
					case 2024:
						FlxTween.tween(black, {alpha: 5}, 1);
						makeInvisibleNotes(true);
					case 2044:
						jumpscare.frames = Paths.getSparrowAtlas('fiveNights/nofriendJumpscare', 'shared');
						jumpscare.animation.addByPrefix('scare', 'jumpscare', 24, false);
						jumpscare.setGraphicSize(FlxG.width * 2, FlxG.height * 2);
						jumpscare.updateHitbox();
						jumpscare.screenCenter();
						jumpscare.scrollFactor.set();
						jumpscare.animation.play('scare');
						jumpscare.antialiasing = FlxG.save.data.globalAntialiasing;
						add(jumpscare);
					case 2058:
						staticBG.frames = Paths.getSparrowAtlas('fiveNights/deathStatic', 'shared');
						staticBG.animation.addByPrefix('static', 'static', 24, true);
						staticBG.setGraphicSize(FlxG.width * 2, FlxG.height * 2);
						staticBG.updateHitbox();
						staticBG.screenCenter();
						staticBG.scrollFactor.set();
						staticBG.animation.play('static');
						staticBG.antialiasing = FlxG.save.data.globalAntialiasing;
						add(staticBG);
					case 2080:
						makeInvisibleNotes(false);
						FlxTween.tween(black, {alpha: 0}, 1);
						remove(jumpscare);
						remove(staticBG);
					case 2144:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub5'), 0.02, 1);
					case 2176:
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
					case 3712:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub6'), 0.02, 1);
					case 3744:
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchDad('pissey', dad.getPosition(), false);
					case 3840:
						trace("BF Float");
						FlxTween.tween(boyfriend, {y: boyfriend.y - 700}, 8);
					//all of this stuff is for pooper's section	
					case 3968:
						makeInvisibleNotes(true);
						boyfriend.y = boyfriend.y + 700;
						FlxG.camera.flash(FlxColor.WHITE, 1);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid3'));
						trace("Phase 3");
					case 3988:
						dad.flipX = !dad.flipX;
					case 3990:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub7'), 0.02, 1);
					case 4051:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub7.1'), 0.02, 1);
					case 4103:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub7.2'), 0.02, 1);
					case 4155:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						dad.visible = false;
						sexDad.visible = false;
					case 4156:
							subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub8'), 0.02, 1);
					case 4183:
						makeInvisibleNotes(false);
						switchDad('pooper', dad.getPosition(), false);	
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 0.5);
						FlxTween.tween(black, {alpha: 0}, 1);
					case 4301:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub9'), 0.02, 1);
					case 4320:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub9.1'), 0.02, 1);
					case 4352:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub9.2'), 0.02, 1);
					case 4379:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub9.3'), 0.02, 1);
					case 4400:
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
					case 4816:
						switchDad('ayo-the-pizza-here', dad.getPosition(), false);
	
						dad.playAnim('pizza');
	
						trace("Ayo the pizza here");
					case 4832:
						switchDad('pooper', dad.getPosition(), false);	
					case 4993:
						// re-using indihome bc im lazy as fuck
						indihome = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/muffin", 'shared'));
						indihome.antialiasing = FlxG.save.data.globalAntialiasing;
						indihome.screenCenter();
						indihome.cameras = [camHUD];
						add(indihome);
	
						trace("EGG McMuffin");
					case 5102:
						remove(indihome);
						camHUD.visible = false;
						boyfriend.playAnim("firstDeath");
						boyfriend.canDance = false;
						hideStuff = new FlxSprite().makeGraphic(2560, 1440, FlxColor.BLACK);
						hideStuff.screenCenter();
						add(hideStuff);
	
						trace("Death Animation");
					case 5139:
						boyfriend.playAnim("deathLoop");
	
						trace("Death Loop");
					case 5155:
						camHUD.visible = true;
						boyfriend.playAnim("idle");
						boyfriend.canDance = true;
						remove(hideStuff);
					case 5264:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchBF('cockey', boyfriend.getPosition(), false);
					case 5324:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub10'), 0.02, 1);
					case 5349:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub10.1'), 0.02, 1);
					case 5372:
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchBF('bf', boyfriend.getPosition(), false);
					case 5479:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchBF('shartey-playable', boyfriend.getPosition(), false);
					case 5501:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub11'), 0.02, 1);
					case 5546:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub12'), 0.02, 1);
					case 5575:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub12.1'), 0.02, 1);
					case 5587:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						FlxTween.tween(black, {alpha: 0}, 1);
					case 5750:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchBF('bf', boyfriend.getPosition(), false);
					case 5965:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchDad('cockey', dad.getPosition(), false);
					case 6074:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						switchDad('pooper', dad.getPosition(), false);
					case 6409:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub13'), 0.02, 1);
					case 6432:
						subtitleManager.addSubtitle(LanguageManager.getTextString('electric_cockaldoodledoo_sub13.1'), 0.02, 1);
					case 6449:
						FlxTween.tween(dad, {alpha: 0}, 6);
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxTween.tween(camHUD, {alpha: 0}, 3);	
						//camHUD.visible = true;
						//camHUD.alpha = 0;
							dadStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0;
						});
					}
	
				// Vinebooms
				for (trigger in newvineBoomTriggers)
				{
					if (curStep == trigger)
					{
						FlxG.camera.flash(FlxColor.WHITE, 0.25);
						var sadBamb:FlxSprite = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/sad_bambi", 'shared'));
						sadBamb.antialiasing = FlxG.save.data.globalAntialiasing;
						sadBamb.screenCenter();
						sadBamb.cameras = [camHUD];
						add(sadBamb);
	
						FlxTween.tween(sadBamb, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
						{
							remove(sadBamb);
						}});
					}
				}
			case 'eletric-cockadoodledoo':
				switch (curStep)
				{
					case 147:
						FlxTween.tween(dad, {alpha: 1}, 0.5);
					case 480:
						switchDad('bartholemew', dad.getPosition(), false);
					case 512:
						switchDad('old-cockey', dad.getPosition(), false);
					case 832:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid2'));
						trace("Phase 2");
						sexDad = new Character(dad.x - 1000, dad.y, "old-cockey");
						add(sexDad);
						dad.alpha = 0;
					case 842:
						switchDad('old-pissey', dad.getPosition(), false);
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 5);
					case 1530:
						shag = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/shaggy from fnf 1", 'shared'));
						shag.screenCenter();
						shag.alpha = 0;
						add(shag);
						trace("Shaggy Fade In");
						FlxTween.tween(shag, {alpha: 1}, 3);
					case 1550:
						remove(shag);
					case 1655:
						for (sprite in cuzsieKapiEletricCockadoodledoo)
						{
							sprite.visible = true;
						}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						switchDad('cuzsiee', dad.getPosition(), false);
						switchBF('kapi', boyfriend.getPosition(), false);
	
						trace("Kapi BG");
	
						defaultCamZoom += 0.2;
					case 1728:
						for (sprite in cuzsieKapiEletricCockadoodledoo)
						{
							sprite.visible = false;
						}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						switchDad('old-pissey', dad.getPosition(), false);
						switchBF('bf', boyfriend.getPosition(), false);
	
						trace("Reset Kapi BG");
	
						defaultCamZoom -= 0.2;
					case 1984:
						FlxG.camera.zoom += 1;
					case 1856:
						trace("BF Float");
						FlxTween.tween(boyfriend, {y: boyfriend.y - 700}, 8);
					case 1983:
						boyfriend.y = boyfriend.y + 700;
						FlxG.camera.flash(FlxColor.WHITE, 1);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/bananaVoid3'));
						trace("Phase 3");
	
					case 2054:
						dad.flipX = !dad.flipX;
					case 2180:
						sexDad.flipX = !sexDad.flipX;
					case 2208:
						FlxG.camera.flash(FlxColor.WHITE, 0.25);
						dad.visible = false;
						sexDad.visible = false;
					case 2239:
						switchDad('old-pooper', dad.getPosition(), false);	
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 0.5);
					case 2624:
						indihome = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/indihome", 'shared'));
						indihome.screenCenter();
						indihome.cameras = [camHUD];
						indihome.antialiasing = FlxG.save.data.globalAntialiasing;
						add(indihome);
						trace("Indihome");
					case 2688:
						remove(indihome);
					case 2818 | 2944:
						switchDad('bambi-new', dad.getPosition(), false);	
					case 2848 | 2972:
						switchDad('old-pooper', dad.getPosition(), false);	
					case 2912:
						switchDad('expunged', dad.getPosition(), false);	
					case 2989:
						switchDad('ayo-the-pizza-here', dad.getPosition(), false);
	
						dad.playAnim('pizza');
	
						trace("Ayo the pizza here");
					case 3008:
						switchDad('old-pooper', dad.getPosition(), false);
					case 3200:
						// re-using indihome bc im lazy as fuck
						indihome = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/muffin", 'shared'));
						indihome.antialiasing = FlxG.save.data.globalAntialiasing;
						indihome.screenCenter();
						indihome.cameras = [camHUD];
						add(indihome);
	
						trace("EGG McMuffin");
					case 3328:
						remove(indihome);
						camHUD.visible = false;
						boyfriend.playAnim("firstDeath");
						boyfriend.canDance = false;
	
						trace("Death Animation");
					case 3360:
						boyfriend.playAnim("deathLoop");
	
						trace("Death Loop");
					case 3392:
						camHUD.visible = true;
						boyfriend.playAnim("idle");
						boyfriend.canDance = true;
					case 3696:
						hideStuff = new FlxSprite().makeGraphic(2560, 1440, FlxColor.BLACK);
						hideStuff.screenCenter();
						add(hideStuff);
						camHUD.visible = false;
					case 3728:
						camHUD.visible = true;
						camHUD.alpha = 0;
	
						dadStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0;
						});
	
						FlxTween.tween(camHUD, {alpha: 1}, 3);
					case 3568:
						FlxTween.tween(dad, {alpha: 0}, 6);	
				}
	
				// Vinebooms
				for (trigger in vineBoomTriggers)
				{
					if (curStep == trigger)
					{
						FlxG.camera.flash(FlxColor.WHITE, 0.25);
						var sadBamb:FlxSprite = new FlxSprite().loadGraphic(Paths.image("eletric-cockadoodledoo/sad_bambi", 'shared'));
						sadBamb.antialiasing = FlxG.save.data.globalAntialiasing;
						sadBamb.screenCenter();
						sadBamb.cameras = [camHUD];
						add(sadBamb);
	
						FlxTween.tween(sadBamb, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
						{
							remove(sadBamb);
						}});
					}
				}
			case 'old-glitch':
				switch (curStep)
				{
					case 480 | 681 | 1390 | 1445 | 1515 | 1542 | 1598 | 1655:
						shakeCam = true;
						camZooming = true;
					case 512 | 688 | 1420 | 1464 | 1540 | 1558 | 1608 | 1745:
						shakeCam = false;
						camZooming = false;
				}
			case "confronting-yourself":
				switch(curStep)
				{
					case 69 /*nice*/:
						for (spr in backgroundSprites)
						{
							FlxTween.tween(spr, {alpha: 0}, 2);
						}
				}
			case "oppression":
				switch(curStep)
				{
					case 272:
						switchDad('bambi-3d-old', dad.getPosition(), false);
					case 543:
						switchDad('dave-3d-standing-bruh-what', dad.getPosition(), false);
					case 889:
						switchDad('bambi-old', dad.getPosition(), false);
					case 976:
						switchBF('dave-3d-standing-bruh-what', boyfriend.getPosition(), false);
					case 1104:
						switchDad('bf', dad.getPosition(), false);
					case 1328:
						switchDad('bambi-beta-2', dad.getPosition(), false);
					case 1344:
						switchBF('bf', boyfriend.getPosition(), false);
					case 1568:
						switchDad('bambi-3d-old', dad.getPosition(), false);
				}
			case 'furiosity':
				switch (curStep)
				{
					case 512 | 768:
						shakeCam = true;
					case 640 | 896:
						shakeCam = false;
				}
			case 'screwed':
				switch (curStep)
				{
					case 1:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 128:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 640:
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 672:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 913:
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('screwed_sub1'), 0.02, 0.6);
					case 960:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
					case 1184:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
				}
			case "duper":
				switch (curStep)
				{
					/*case 263 | 272 | 280 | 288 | 296 | 304 | 312 | 320 | 328 | 336 | 344 | 352 | 360 | 368 | 380 | 388 | 396 | 404 |
					412 | 420 | 428 | 436 | 444 | 452 | 460 | 468 | 480 | 488 | 502 | 516 | 524 | 532 | 540 | 548 | 556 | 564 | 572 | 580 |
					588 | 596 | 604 | 612 | 620 | 630 | 340 | 648 | 656 | 664 | 672 | 680 | 688 | 696 | 704 | 712 | 720 | 728 | 736 | 744 |
					752 | 764 | 772 | 780 | 788 | 796 | 804 | 812 | 820 | 828 | 835 | 844 | 852 | 860 | 868 | 876 | 886 | 896 | 904 | 912 |
					920 | 928 | 936 | 944 | 952 | 960 | 968 | 972 | 980 | 988 | 996 | 1004 | 1014:
						defaultCamZoom = 1.2;
					case 268 | 276 | 284 | 292 | 300 | 308 | 316 | 324 | 332 | 340 | 348 | 356 | 364 | 374 | 384 | 392 | 400 | 408 |
					416 | 424 | 432 | 440 | 448 | 456 | 464 | 472 | 484 | 492 | 512 | 520 | 528 | 536 | 544 | 552 | 560 | 568 | 756 | 584 |
					592 | 600 | 608 | 616 | 624 | 636 | 644 | 652 | 660 | 668 | 676 | 684 | 692 | 700 | 708 | 716 | 724 | 732 | 740 | 748 |
					758 | 768 | 776 | 784 | 792 | 800 | 808 | 816 | 824 | 832 | 840 | 848 | 856 | 864 | 872 | 880 | 892 | 900 | 908 | 916 |
					924 | 932 | 940 | 948 | 956 | 964 | 968 | 976 | 984 | 992 | 1000 | 1008 | 1020:
						defaultCamZoom = 0.8;*/
					case 240:
						defaultCamZoom += 0.1;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('duper_sub1'), 0.02, 1);
					case 256:
						defaultCamZoom -= 0.1;
						FlxG.camera.flash();
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 1024:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						defaultCamZoom = 0.65;
					case 1282:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						defaultCamZoom = 0.8;
					case 1536:
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 1536 | 1664:
						FlxG.camera.flash(FlxColor.WHITE, 1);
					case 1781:
						subtitleManager.addSubtitle(LanguageManager.getTextString('duper_sub2'), 0.02, 1);
					case 1792:
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 2016:
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 2026:
						makeInvisibleNotes(true);
					case 2032:
						subtitleManager.addSubtitle(LanguageManager.getTextString('duper_sub3'), 0.02, 1);
					case 2044:
						subtitleManager.addSubtitle(LanguageManager.getTextString('duper_sub4'), 0.02, 1);
					case 2048:
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 2780:
						FlxTween.tween(black, {alpha: 0.4}, 1);
						defaultCamZoom += 0.3;
					/*case 2784:
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
							{
								camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
							}
						#end
						FlxTween.tween(black, {alpha: 0.7}, (Conductor.stepCrochet / 1000) * 8);*/
					case 2800:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						camHUD.setFilters([]);
						remove(black);
						defaultCamZoom -= 0.3;
				}
			case 'bonkers':
				switch (curStep)
				{
					case 96:
						subtitleManager.addSubtitle(LanguageManager.getTextString('bonkers_sub1'), 0.02, 1);
						black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 112:
						subtitleManager.addSubtitle(LanguageManager.getTextString('bonkers_sub2'), 0.02, 1);
					case 128:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						FlxTween.tween(black, {alpha: 0}, 1);
					case 1152 | 1160 | 1172 | 1177 | 1184 | 1192 | 1205 | 1209 | 1216 | 1224 | 1237 | 1241 | 1248 | 1257 | 1270 | 1273:
						FlxG.camera.flash(FlxColor.WHITE, 1);
					case 1024:
						defaultCamZoom += 0.1;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
					case 1277:
						defaultCamZoom -= 0.1;
						FlxG.camera.flash(FlxColor.WHITE, 1);
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
				}
			case 'cuzsie-x-kapi-shipping-cute':
				switch (curStep)
				{
					case 425:
						subtitleManager.addSubtitle(LanguageManager.getTextString('cuzsie_x_kapi_shipping_cute_sub1'), 0.02, 1);
						black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 443:
						subtitleManager.addSubtitle(LanguageManager.getTextString('cuzsie_x_kapi_shipping_cute_sub3'), 0.02, 1);
					case 494:
						subtitleManager.addSubtitle(LanguageManager.getTextString('cuzsie_x_kapi_shipping_cute_sub4'), 0.02, 1);
					case 507:
						subtitleManager.addSubtitle(LanguageManager.getTextString('cuzsie_x_kapi_shipping_cute_sub5'), 0.02, 1);
					case 528:
						FlxG.camera.flash(FlxColor.WHITE, 1);
						FlxTween.tween(black, {alpha: 0}, 1);
				}
			case 'foolhardy':
				switch (curStep)
				{
					case 1:
						FlxTween.tween(dad, {alpha: 1}, 5);
					case 266:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub1'), 0.02, 1);
						black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 290:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub1.1'), 0.02, 1);
					case 512:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub2'), 0.02, 1);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 544:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub2.1'), 0.02, 1);
					case 1045:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub3'), 0.02, 1);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 1408:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub4'), 0.02, 1);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 1450:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub4.1'), 0.02, 1);
					case 2062:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub5'), 0.02, 1);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 2304:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub6'), 0.02, 1);
						FlxTween.tween(black, {alpha: 0.6}, 1);
					case 2352:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub6.1'), 0.02, 1);
					case 311 | 576 | 1088 | 1472 | 2112 | 2368:
						FlxTween.tween(black, {alpha: 0}, 1);
					case 2427 | 2428 | 2429 | 2430:
						FlxG.camera.shake(0.05);
						dad.alpha -= 0.05;
					case 2432 | 2434 | 2435 | 2436 | 2437 | 2438 | 2439 | 2440:
						dad.alpha = 0.6;
						FlxG.camera.stopFX();
					case 2943 | 2946 | 2948 | 2950 | 2452 | 2454:
						dad.alpha -= 0.2;
					case 2961:
						subtitleManager.addSubtitle(LanguageManager.getTextString('foolhardy_sub7'), 0.02, 1);
						FlxTween.tween(black, {alpha: 0.6}, 1);
				}
			case 'importumania':
				switch (curStep)
				{
					// Bambi
					case 1:
						iconP2.alpha = 0;
						iconP1.alpha = 0;
						switchDad('bambi-angey', dad.getPosition(), false);
						dad.alpha = 0;
					case 128:
						for (sprite in bambiFarmDream)
						{
							sprite.visible = true;
						}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
						dad.y += 370;
						dad.x += 200;

						trace("Bambi Farm");
					case 160:
						FlxTween.tween(dad, {alpha: 1}, 5);
						FlxTween.tween(iconP2, {alpha: 1}, 5);
					case 179:
						FlxTween.tween(gf, {alpha: 1}, 5);
					case 192:
						FlxTween.tween(boyfriend, {alpha: 1}, 5);
						FlxTween.tween(iconP1, {alpha: 1}, 5);
					case 256 | 1664:
						FlxG.camera.flash(FlxColor.WHITE, 1);
					case 1344:
						FlxTween.tween(dad, {alpha: 0}, 6);
						FlxTween.tween(iconP2, {alpha: 0}, 6);
					case 1408:
						black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 5}, 1);
						makeInvisibleNotes(true);
						FlxTween.tween(camHUD, {alpha: 0}, 5);
					case 1521:
						for (sprite in bambiFarmDream)
						{
							sprite.visible = false;
						}
						trace("Bambi Farm is just a dream...");
					// Dave
					case 1536:
						for (sprite in daveHouseDream)
							{
								sprite.visible = true;
							}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
						
						trace("Dave House");

						dad.x = 50;
						dad.y = 270;
						health = 1;
					case 1600:
						switchDad('dave', dad.getPosition(), false);
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 5);
						FlxTween.tween(iconP2, {alpha: 1}, 5);
					case 2176:
						switchDad('dave-annoyed', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
					case 2752:
						FlxTween.tween(dad, {alpha: 0}, 6);
						FlxTween.tween(iconP2, {alpha: 0}, 6);
					case 2823:
						FlxTween.tween(black, {alpha: 5}, 1);
						FlxTween.tween(camHUD, {alpha: 0}, 5);
						makeInvisibleNotes(true);
					case 2850:
						for (sprite in daveHouseDream)
							{
								sprite.visible = false;
							}
						trace("Dave House is just a dream...");
					// Tristan
					case 2944:
						for (sprite in tristanHouseDream)
							{
								sprite.visible = true;
							}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
						health = 1;
						
						trace("Tristan in Dave House!!!!!!!!!!!!!!!!!!!!");

						dad.x = 50;
						dad.y = 500;
					case 3008:
						switchDad('tristan-opponent', dad.getPosition(), false);
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 5);
						FlxTween.tween(iconP2, {alpha: 1}, 5);
					case 4160:
						FlxTween.tween(dad, {alpha: 0}, 6);
						FlxTween.tween(iconP2, {alpha: 0}, 6);
					case 4192:
						FlxTween.tween(black, {alpha: 5}, 1);
						makeInvisibleNotes(true);
						FlxTween.tween(camHUD, {alpha: 0}, 5);						
					case 4352:
						for (sprite in tristanHouseDream)
							{
								sprite.visible = false;
							}
						FlxG.camera.flash(FlxColor.WHITE, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
							
						trace("Tristan is dead!!!!!!!!!!!!!!!!!!!!");
	
						dad.x = 0;
						dad.y = 0;
						health = 1;

						mcStarted = true;
						cheatPart = true;
					// Expunged
					case 4416:
						switchDad('bambi-3d', dad.getPosition(), false);
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 5);
						FlxTween.tween(iconP2, {alpha: 1}, 5);
						FlxG.camera.flash(FlxColor.WHITE, 1);
					case 5280:
						FlxTween.tween(camHUD, {alpha: 0}, 5);
						makeInvisibleNotes(true);
						cheatPart = false;
					// Expunged Unfair
					case 5376:
						switchDad('bambi-unfair', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/scarybg'));
						weirdBG.setGraphicSize(Std.int(weirdBG.width * 3));
						weirdBG.setPosition(0, 200);
						health = 2;
						unfairPart = true;

						dad.x = 0;
						dad.y = 0;

						theFunne = true;
						FlxTween.tween(camHUD, {alpha: 1}, 5);
					case 5507:
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub1'), 0.02, 0.6);
					case 5517:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub2'), 0.02, 0.6);
					case 5535:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub3'), 0.02, 0.6);
					case 5553:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub4'), 0.02, 1.5);
					case 5583:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub5'), 0.02, 0.6);
					case 5595:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub6'), 0.02, 1);
					case 5609:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub7'), 0.02, 1);
					case 5632:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
					case 6448:
						FlxTween.tween(dad, {alpha: 0}, 6);
						FlxTween.tween(iconP2, {alpha: 0}, 6);
					case 6497:
						FlxTween.tween(black, {alpha: 5}, 1);
						makeInvisibleNotes(true);
						FlxTween.tween(camHUD, {alpha: 0}, 5);
					// 3D Dave
					case 6656:
						for (sprite in daveHouseDream)
							{
								sprite.visible = false;
							}
						trace("Dave s back");
						FlxG.camera.flash(FlxColor.WHITE, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
						dad.x = 50;
						dad.y = 80;

						health = 1;
						theFunne = false;
						unfairPart = false;
						mcStarted = false;
					case 6688:
						switchDad('dave-annoyed', dad.getPosition(), false);
						dad.alpha = 0;
						dad.x = 50;
						dad.y = 270;
						FlxTween.tween(dad, {alpha: 1}, 5);
						FlxTween.tween(iconP2, {alpha: 1}, 5);
					case 6784 | 6816 | 6848 | 6880:
						FlxG.sound.play(Paths.sound('static'), 0.1);
						switchDad('dave-angey', dad.getPosition(), false);
						dad.x = 0;
						dad.y = 0;

						weirdBG.loadGraphic(Paths.image('backgrounds/void/redsky'));
						weirdBG.setGraphicSize(Std.int(weirdBG.width * 3));						
					case 6788:
						switchDad('dave-annoyed', dad.getPosition(), false);
						dad.playAnim('um', true);
						dad.x = 50;
						dad.y = 270;
						weirdBG.loadGraphic(Paths.image('backgrounds/void/scarybg'));
						weirdBG.setGraphicSize(Std.int(weirdBG.width * 3));
					case 6821 | 6849 | 6881:
						switchDad('dave-annoyed', dad.getPosition(), false);
						dad.animation.play('scared', true);
						dad.x = 50;
						dad.y = 270;
						weirdBG.loadGraphic(Paths.image('backgrounds/void/scarybg'));
						weirdBG.setGraphicSize(Std.int(weirdBG.width * 3));
					case 6912:
						FlxG.sound.play(Paths.sound('static'), 0.1);
						switchDad('dave-angey', dad.getPosition(), false);
						dad.x = 0;
						dad.y = 0;

						weirdBG.loadGraphic(Paths.image('backgrounds/void/redsky'));
						weirdBG.setGraphicSize(Std.int(weirdBG.width * 3));

						shapeNoteWarning2 = new FlxSprite().loadGraphic(Paths.image("ui/shapeNoteWarning", 'shared'));
						shapeNoteWarning2.antialiasing = false;
						shapeNoteWarning2.scrollFactor.set();
						shapeNoteWarning2.cameras = [camHUD];
						shapeNoteWarning2.alpha = 0;
						FlxTween.tween(shapeNoteWarning2, {alpha: 1}, 1);
						add(shapeNoteWarning2);						
					case 6944:
						FlxTween.tween(shapeNoteWarning2, {alpha: 0}, 1);
					case 7168 | 7296 | 7392 | 7680 | 7808 | 7904:
						defaultCamZoom = 1.1;
						shakeCam = true;
						FlxG.camera.zoom += 0.2;

						if (localFunny != CharacterFunnyEffect.Recurser)
							{
								shakeCam = true;
								pre3dSkin = boyfriend.curCharacter;
								for (char in [boyfriend, gf])
								{
									if (char.skins.exists('3d'))
									{
										if (char == boyfriend)
										{
											switchBF(char.skins.get('3d'), char.getPosition());
										}
										else if (char == gf)
										{
											switchGF(char.skins.get('3d'), char.getPosition());
										}
									}
								}
							}
					case 7232 | 7360 | 7424 | 7744 | 7872 | 7936:
						defaultCamZoom = 0.9;
						shakeCam = false;
						FlxG.camera.zoom += 0.2;

						if (localFunny != CharacterFunnyEffect.Recurser)
							{
								if (boyfriend.curCharacter != pre3dSkin)
								{
									switchBF(pre3dSkin, boyfriend.getPosition());
									switchGF(boyfriend.skins.get('gfSkin'), gf.getPosition());
								}
							}
					case 8000:
						FlxTween.tween(dad, {alpha: 0}, 6);
						FlxTween.tween(iconP2, {alpha: 0}, 6);
					case 8032:
						FlxTween.tween(black, {alpha: 5}, 1);
						makeInvisibleNotes(true);
						FlxTween.tween(camHUD, {alpha: 0}, 5);
					// Expunged True Form
					case 8192:
						defaultCamZoom = 0.5;
						trace("Expunged true form lo");
						FlxG.camera.flash(FlxColor.WHITE, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(black, {alpha: 0}, 1);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
						weirdBG.loadGraphic(Paths.image('backgrounds/void/exploit/creepyRoom'));
						weirdBG.setGraphicSize(Std.int(weirdBG.width * 2));
						weirdBG.setPosition(0, 200);
						health = 1;
						exploPart = true;
						mcStarted = true;
					case 8320:
						switchDad('expunged', dad.getPosition(), false);
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 5);
						FlxTween.tween(iconP2, {alpha: 1}, 5);
					case 8416:
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.6}, 1);
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub8'), 0.02, 0.6);
					case 8426:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub9'), 0.02, 0.6);
					case 8432:
						subtitleManager.addSubtitle(LanguageManager.getTextString('importumania_sub10'), 0.02, 0.6);
					case 8448:
						defaultCamZoom -= 0.2;
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
						FlxTween.tween(camHUD, {alpha: 1}, 5);
					case 8704 | 8736 | 8832 | 8864:
						shakeCam = true;
						FlxG.camera.zoom += 0.2;
					case 8728 | 8760 | 8856 | 8888:
						shakeCam = false;
						FlxG.camera.zoom += 0.2;
					case 9216:
						defaultCamZoom = 0.9;
						for (sprite in bambiFarmDream)
						{
							sprite.visible = true;
						}
						switchDad('bambi-mad', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);

						dad.x += 100;
						dad.y += 500;
					case 9280:
						for (sprite in daveHouseDream)
						{
							sprite.visible = true;
						}
						for (sprite in bambiFarmDream)
						{
							sprite.visible = false;
						}
						switchDad('dave', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
						dad.x = 50;
						dad.y = 270;
					case 9296:
						for (sprite in daveHouseDream)
						{
							sprite.visible = false;
						}
						switchDad('dave-angey', dad.getPosition(), false);
						FlxG.sound.play(Paths.sound('static'), 0.1);					
					case 9344:
						for (sprite in tristanHouseDream)
						{
							sprite.visible = true;
						}
						switchDad('tristan-opponent', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
						dad.x = 50;
						dad.y = 500;
					case 9408:
						for (sprite in tristanHouseDream)
						{
							sprite.visible = false;
						}
						switchDad('bambi-3d', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
						cheatPart = true;
						dad.x = 0;
						dad.y = 0;						
					case 9424:
						switchDad('bambi-unfair', dad.getPosition(), false);
						FlxG.camera.flash(FlxColor.WHITE, 1);
						cheatPart = false;
						unfairPart = true;
					case 9472:
						defaultCamZoom = 0.5;
						switchDad('expunged', dad.getPosition(), false);
						unfairPart = false;
						exploPart = true;
						FlxG.camera.flash(FlxColor.WHITE, 1);

						shakeCam = true;
						FlxG.camera.zoom += 0.2;

						modchart = ExploitationModchartType.Sex;
						if (modchartoption) {
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
						}

						windowProperties = [
							Application.current.window.x,
							Application.current.window.y,
							Application.current.window.width,
							Application.current.window.height
						];

						#if windows
						if (modchartoption) popupWindow();
						#end
					case 9504 | 9632:
						shakeCam = true;
						FlxG.camera.zoom += 0.2;
					case 9528 | 9624 | 9656:
						shakeCam = false;
						FlxG.camera.zoom += 0.2;
					case 9600:
						shakeCam = true;
						FlxG.camera.zoom += 0.2;

						modchart = ExploitationModchartType.Figure8;
						if (modchartoption) {
						dadStrums.forEach(function(strum:StrumNote)
						{
							strum.resetX();
						});
						playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
						}
					case 9856:
						#if windows
						if (window != null)
						{
							window.close();
							expungedWindowMode = false;
							window = null;
							FlxTween.tween(Application.current.window, {x: windowProperties[0], y: windowProperties[1], width: windowProperties[2], height: windowProperties[3]}, 1, {ease: FlxEase.circInOut});
							FlxTween.tween(iconP2, {alpha: 0}, 1, {ease: FlxEase.bounceOut});
						}
						#end

						windowProperties = [
							Application.current.window.x,
							Application.current.window.y,
							Application.current.window.width,
							Application.current.window.height
						];
					case 9859:
						PlatformUtil.sendWindowsNotification("ERROR", "expunged.dat is missing.");
						FlxTween.tween(black, {alpha: 5}, 1);
						FlxTween.tween(camHUD, {alpha: 0}, 5);
						makeInvisibleNotes(true);
				}
		}
		if (SONG.song.toLowerCase() == 'exploitation' && curStep % 8 == 0)
		{
			var fonts = ['arial', 'chalktastic', 'openSans', 'pkmndp', 'Koda135759-vmm2O', 'AnimeAce20BbBold-2Av', 'DeterminationSansWebRegular-369X',
			'PonyvilleMedium-3636', 'SonicTurbo-K7D1D', 'SuperMarioDsRegular-Ea4R8', 'barcode', 'LCD Nova', 'vcr'];
			var chosenFont = fonts[FlxG.random.int(0, fonts.length)];
			scoreTxt.font = Paths.font('exploit/${chosenFont}.ttf');
			kadeEngineWatermark.font = Paths.font('exploit/${chosenFont}.ttf');
			kadeEngineWatermark2.font = Paths.font('exploit/${chosenFont}.ttf');
			kadeEngineWatermark3.font = Paths.font('exploit/${chosenFont}.ttf');
			judgementCounter.font = Paths.font('exploit/${chosenFont}.ttf');
			creditsWatermark.font = Paths.font('exploit/${chosenFont}.ttf');
			extraTxt.font = Paths.font('exploit/${chosenFont}.ttf');
			healthTxt.font = Paths.font('exploit/${chosenFont}.ttf');
			if (songName != null)
			{
				songName.font = Paths.font('exploit/${chosenFont}.ttf');
			}
		}
		#if desktop
		DiscordClient.changePresence(detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") ",
			"Acc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC, true,
			FlxG.sound.music.length
			- Conductor.songPosition);
		#end
	}

	override function beatHit()
	{
		super.beatHit();

		if (spotLightPart && spotLight != null && spotLight.exists && curBeat % 3 == 0)
		{
			FlxTween.cancelTweensOf(spotLight);
			if (spotLight.health != 3)
			{
				FlxTween.tween(spotLight, {angle: 2}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.expoInOut});
				spotLight.health = 3;
			}
			else
			{
				FlxTween.tween(spotLight, {angle: -2}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.expoInOut});
				spotLight.health = 1;
			}
		}

		var currentSection = SONG.notes[Std.int(curStep / 16)];
		if (!UsingNewCam)
		{
			if (generatedMusic && currentSection != null)
			{
				if (curBeat % 4 == 0)
				{
					// trace(currentSection.mustHitSection);
				}

				focusOnDadGlobal = !currentSection.mustHitSection;
				ZoomCam(!currentSection.mustHitSection);
			}
		}
		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, scrollType == 'downscroll' ? FlxSort.ASCENDING : FlxSort.DESCENDING);
		}

		if (currentSection != null)
		{
			if (currentSection.changeBPM)
			{
				Conductor.changeBPM(currentSection.bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);
		}
		if (dad.animation.finished)
		{
			switch (SONG.song.toLowerCase())
			{
				case 'warmup':
					dad.dance();
					if (dadmirror != null)
					{
						dadmirror.dance();
					}
				default:
					if (dad.holdTimer <= 0 && curBeat % 2 == 0)
					{
						dad.dance();
						if (dadmirror != null)
						{
							dadmirror.dance();
						}

						dadNoteCamOffset[0] = 0;
						dadNoteCamOffset[1] = 0;
					}
			}
		}

		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		#if SHADERS_ENABLED
		wiggleShit.update(Conductor.crochet);
		#end
		
		if (curBeat % gfSpeed == 0)
		{
			if (!shakeCam && gf.canDance)
			{
				gf.dance();
			}
		}

		if (camZooming && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}
		if (crazyZooming)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}	
		if (curBeat % 4 == 0 && SONG.song.toLowerCase() == 'recursed')
		{
			freeplayBG.alpha = 0.8;
			charBackdrop.alpha = 0.8;

			for (char in alphaCharacters)
			{
				for (letter in char)
				{
					letter.alpha = 0.4;
				}
			}
		}
		if (curBeat % 2 == 0)
		{
			crowdPeople.forEach(function(crowdPerson:BGSprite)
			{
				crowdPerson.animation.play('idle', true);
			});
		}
		if (curBeat % 2 == 0 && tristan != null)
		{
			tristan.animation.play(curTristanAnim);
		}
		if (curBeat % 4 == 0 && spotLightPart && spotLight != null)
		{
			updateSpotlight(currentSection.mustHitSection);
		}
		if (SONG.song.toLowerCase() == 'shredder' && curBeat % 4 == 0)
		{
			var curSection = SONG.notes.indexOf(currentSection);
			guitarSection = curSection >= 64 && curSection < 80;
			dadStrumAmount = guitarSection ? 5 : Main.keyAmmo[mania];
			if (guitarSection)
			{
				notes.forEachAlive(function(daNote:Note)
				{
					daNote.MyStrum = null;
				});
			}
		}
		switch (curSong.toLowerCase())
		{
			case 'mastered':
				switch (curStep)
				{
					case 384 | 895 | 1412:
						switchDad('dave-3d-mastered', dad.getPosition());
					case 639 | 1152 | 1919:
						switchDad('dave-splitathon-mastered', dad.getPosition());
					case 1152:
						switchDad('dave-scared-mastered', dad.getPosition());
					case 1176:
						switchDad('dave-3d-mastered', dad.getPosition());
				        case 639 | 1152 | 1919:
						switchDad('dave-splitathon-mastered', dad.getPosition());
				}
			//exploitation stuff
			case 'exploitation':
				switch(curStep)
			    {
					case 32:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub1'), 0.02, 1);
					case 56:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub2'), 0.02, 0.8);
					case 64:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub3'), 0.02, 1);
					case 85:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub4'), 0.02, 1);
					case 99:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub5'), 0.02, 0.5);
					case 105:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub6'), 0.02, 0.5);
					case 117:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub7'), 0.02, 1);
					case 512:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub8'), 0.02, 1);
					case 524:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub9'), 0.02, 1);
					case 533:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub10'), 0.02, 0.7);
					case 545:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub11'), 0.02, 1);
					case 566:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub12'), 0.02, 1);
					case 1263:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub13'), 0.02, 0.3);
					case 1270:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub14'), 0.02, 0.3);
					case 1276:
						subtitleManager.addSubtitle(LanguageManager.getTextString('exploit_sub15'), 0.02, 0.3);
					case 1100:
						PlatformUtil.sendWindowsNotification("Anticheat.dll", "Potential threat detected: expunged.dat");
				}
				if (modchartoption) {
					switch (curBeat)
					{
						case 40:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 44:
							if (mania == 5)
								switchNotePositions([1, 2, 8, 10, 4, 5, 3, 11, 0, 6, 9, 7, 18, 12, 16, 22, 23, 14, 21, 19, 15, 13, 17, 20]);
							else
								switchNotePositions([0,1,3,2,4,5,7,6]);
						case 46:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 56:
							if (mania == 5)
								switchNotePositions([6, 10, 2, 5, 9, 0, 3, 1, 8, 7, 4, 11, 23, 17, 20, 21, 19, 15, 13, 12, 18, 14, 16, 22]);
							else
								switchNotePositions([1,3,2,0,5,7,6,4]);
						case 60:
							if (mania == 5)
								switchNotePositions([17, 23, 18, 20, 21, 22, 14, 12, 19, 16, 13, 15, 1, 5, 2, 4, 10, 0, 9, 11, 7, 6, 3, 8]);
							else
								switchNotePositions([4,6,7,5,0,2,3,1]);
							switchNoteScroll(false);
						case 62:
							if (mania == 5)
								switchNotePositions([21, 3, 15, 17, 22, 9, 7, 2, 18, 4, 8, 5, 0, 23, 19, 14, 20, 12, 6, 10, 11, 16, 1, 13]);
							else
								switchNotePositions([7,1,0,2,3,5,4,6]);
							switchNoteScroll(false);
						case 120:
							switchNoteScroll();
						case 124:
							switchNoteScroll();
						case 72:
							if (mania == 5)
								switchNotePositions([9, 18, 16, 23, 3, 20, 7, 1, 5, 8, 14, 17, 11, 12, 22, 4, 10, 6, 13, 19, 2, 15, 0, 21]);
							else
								switchNotePositions([6,7,2,3,4,5,0,1]);
						case 76:
							if (mania == 5)
								switchNotePositions([23, 0, 17, 21, 16, 15, 6, 12, 10, 1, 19, 20, 3, 22, 14, 9, 13, 11, 2, 4, 5, 7, 18, 8]);
							else
								switchNotePositions([6,7,4,5,2,3,0,1]);
						case 80:
							if (mania == 5)
								switchNotePositions([6, 2, 5, 18, 12, 1, 20, 23, 13, 15, 0, 11, 22, 19, 4, 14, 9, 7, 16, 10, 8, 21, 17, 3]);
							else
								switchNotePositions([1,0,2,4,3,5,7,6]);
						case 88:
							if (mania == 5)
								switchNotePositions([10, 5, 6, 17, 13, 21, 8, 22, 11, 9, 4, 7, 0, 23, 16, 12, 1, 14, 18, 3, 19, 2, 20, 15]);
							else
								switchNotePositions([4,2,0,1,6,7,5,3]);
						case 90:
							switchNoteSide();
						case 92:
							switchNoteSide();
						case 112:
							dadStrums.forEach(function(strum:StrumNote)
							{
								var targetPosition = (mania == 5 ? 13 : FlxG.width / 8) + Note.swagWidth * Math.abs(2 * strum.ID) + 78 - (78 / 2);
								FlxTween.completeTweensOf(strum);
								strum.angle = 0;
				
								FlxTween.angle(strum, strum.angle, strum.angle + 360, 0.2, {ease: FlxEase.circOut});
								FlxTween.tween(strum, {x: targetPosition}, 0.6, {ease: FlxEase.backOut});
								
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								var targetPosition = (mania == 5 ? 13 : FlxG.width / 8) + Note.swagWidth * Math.abs((2 * strum.ID) + 1) + 78 - (78 / 2);
								
								FlxTween.completeTweensOf(strum);
								strum.angle = 0;
				
								FlxTween.angle(strum, strum.angle, strum.angle + 360, 0.2, {ease: FlxEase.circOut});
								FlxTween.tween(strum, {x: targetPosition}, 0.6, {ease: FlxEase.backOut});
							});
						case 143:
							swapGlitch(Conductor.crochet / 1500, 'cheating');
						case 144:
							modchart = ExploitationModchartType.Cheating; //While we're here, lets bring back a familiar modchart
						case 191:
							swapGlitch(Conductor.crochet / 1500, 'expunged');
						case 192:
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							modchart = ExploitationModchartType.Cyclone;
						case 224:
							modchart = ExploitationModchartType.Jitterwave;
						case 255:
							swapGlitch(Conductor.crochet / 4000, 'unfair');
						case 256:
							modchart = ExploitationModchartType.Unfairness;
						case 287:
							swapGlitch(Conductor.crochet / 1500, 'chains');
						case 288:
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							modchart = ExploitationModchartType.PingPong;
						case 455:
							swapGlitch(Conductor.crochet / 1500, 'cheating-2');
							modchart = ExploitationModchartType.None;
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
								strum.resetY();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
								strum.resetY();
							});
						case 456:
							if (mania == 5)
								switchNotePositions([7, 10, 1, 2, 11, 8, 6, 3, 0, 4, 9, 5, 13, 14, 15, 18, 17, 22, 16, 23, 20, 12, 19, 21]);
							else
								switchNotePositions([1,0,2,3,4,5,7,6]);
						case 460:
							if (mania == 5)
								switchNotePositions([2, 10, 8, 9, 5, 6, 4, 3, 11, 1, 0, 7, 22, 17, 18, 21, 19, 23, 12, 20, 13, 15, 16, 14]);
							else
								switchNotePositions([1,2,0,3,4,7,5,6]);
						case 465:
							if (mania == 5)
								switchNotePositions([3, 0, 9, 6, 10, 1, 5, 2, 7, 8, 11, 4, 17, 13, 18, 12, 15, 20, 19, 21, 22, 14, 16, 23]);
							else
								switchNotePositions([1,2,3,0,7,4,5,6]);
						case 470:
							if (mania == 5)
								switchNotePositions([2, 6, 0, 7, 21, 4, 20, 13, 11, 1, 12, 22, 5, 17, 16, 10, 9, 14, 3, 8, 23, 15, 18, 19]);
							else
								switchNotePositions([6,2,3,0,7,4,5,1]);
						case 475:
							if (mania == 5)
								switchNotePositions([17, 6, 10, 7, 2, 12, 21, 20, 4, 19, 9, 15, 0, 1, 3, 22, 23, 14, 16, 11, 8, 5, 18, 13]);
							else
								switchNotePositions([2,6,3,0,7,5,4,1]);
						case 480:
							if (mania == 5)
								switchNotePositions([17, 9, 16, 13, 15, 19, 14, 18, 3, 11, 2, 20, 4, 0, 8, 23, 6, 5, 10, 1, 7, 22, 21, 12]);
							else
								switchNotePositions([2,3,6,0,5,7,4,1]);
						case 486:
							swapGlitch((Conductor.crochet / 4000) * 2, 'expunged');
						case 487:
							modchart = ExploitationModchartType.ScrambledNotes;
					}
				}
			case 'importumania':
				if (modchartoption){
					switch (curBeat)
					{
						case 1088:
							modchart = ExploitationModchartType.Cheating; //While we're here, lets bring back a familiar modchart again
						case 1344:
							modchart = ExploitationModchartType.Unfairness;
						case 1629:
							modchart = ExploitationModchartType.None;
						case 1664:
							switchNoteScroll(false);
						case 1668:
							if (mania == 5)
								switchNotePositions([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]);
							else
								switchNotePositions([0,1,2,3,4,5,6,7]);
							switchNoteScroll(false);
						case 2120:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2124:
							if (mania == 5)
								switchNotePositions([1, 2, 8, 10, 4, 5, 3, 11, 0, 6, 9, 7, 18, 12, 16, 22, 23, 14, 21, 19, 15, 13, 17, 20]);
							else
								switchNotePositions([0,1,3,2,4,5,7,6]);
						case 2126:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2136:
							if (mania == 5)
								switchNotePositions([6, 10, 2, 5, 9, 0, 3, 1, 8, 7, 4, 11, 23, 17, 20, 21, 19, 15, 13, 12, 18, 14, 16, 22]);
							else
								switchNotePositions([1,3,2,0,5,7,6,4]);
						case 2140:
							if (mania == 5)
								switchNotePositions([17, 23, 18, 20, 21, 22, 14, 12, 19, 16, 13, 15, 1, 5, 2, 4, 10, 0, 9, 11, 7, 6, 3, 8]);
							else
								switchNotePositions([4,6,7,5,0,2,3,1]);
							switchNoteScroll(false);
						case 2141:
							if (mania == 5)
								switchNotePositions([21, 3, 15, 17, 22, 9, 7, 2, 18, 4, 8, 5, 0, 23, 19, 14, 20, 12, 6, 10, 11, 16, 1, 13]);
							else
								switchNotePositions([7,1,0,2,3,5,4,6]);
							switchNoteScroll(false);
						case 2146:
							switchNoteScroll();
						case 2147:
							switchNoteScroll();
						case 2152:
							if (mania == 5)
								switchNotePositions([9, 18, 16, 23, 3, 20, 7, 1, 5, 8, 14, 17, 11, 12, 22, 4, 10, 6, 13, 19, 2, 15, 0, 21]);
							else
								switchNotePositions([6,7,2,3,4,5,0,1]);
						case 2156:
							if (mania == 5)
								switchNotePositions([23, 0, 17, 21, 16, 15, 6, 12, 10, 1, 19, 20, 3, 22, 14, 9, 13, 11, 2, 4, 5, 7, 18, 8]);
							else
								switchNotePositions([6,7,4,5,2,3,0,1]);
						case 2168:
							switchNoteSide();
						case 2170:
							switchNoteSide();
						case 2176:
							dadStrums.forEach(function(strum:StrumNote)
							{
								var targetPosition = (mania == 5 ? 13 : FlxG.width / 8) + Note.swagWidth * Math.abs(2 * strum.ID) + 78 - (78 / 2);
								FlxTween.completeTweensOf(strum);
								strum.angle = 0;
				
								FlxTween.angle(strum, strum.angle, strum.angle + 360, 0.2, {ease: FlxEase.circOut});
								FlxTween.tween(strum, {x: targetPosition}, 0.6, {ease: FlxEase.backOut});
								
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								var targetPosition = (mania == 5 ? 13 : FlxG.width / 8) + Note.swagWidth * Math.abs((2 * strum.ID) + 1) + 78 - (78 / 2);
								
								FlxTween.completeTweensOf(strum);
								strum.angle = 0;
				
								FlxTween.angle(strum, strum.angle, strum.angle + 360, 0.2, {ease: FlxEase.circOut});
								FlxTween.tween(strum, {x: targetPosition}, 0.6, {ease: FlxEase.backOut});
							});
							switchNoteScroll(false);
						case 2178:
							switchNoteScroll(false);
						case 2180:
							switchNoteScroll(false);
						case 2181:
							switchNoteScroll(false);
						case 2184:
							switchNoteScroll(false);
						case 2186:
							switchNoteScroll(false);
						case 2188:
							switchNoteScroll(false);
						case 2189:
							switchNoteScroll(false);
						case 2192:
							switchNoteScroll(false);
						case 2194:
							switchNoteScroll(false);
						case 2196:
							switchNoteScroll(false);
						case 2197:
							switchNoteScroll(false);
						case 2200:
							switchNoteScroll(false);
						case 2202:
							switchNoteScroll(false);
						case 2204:
							switchNoteScroll(false);
						case 2205:
							switchNoteScroll(false);
						case 2208:
							switchNoteScroll(false);
						case 2210:
							switchNoteScroll(false);
						case 2212:
							switchNoteScroll(false);
						case 2213:
							switchNoteScroll(false);
						case 2216:
							switchNoteScroll(false);
						case 2218:
							switchNoteScroll(false);
						case 2220:
							switchNoteScroll(false);
						case 2221:
							switchNoteScroll(false);
						case 2208:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2210:
							if (mania == 5)
								switchNotePositions([1, 2, 8, 10, 4, 5, 3, 11, 0, 6, 9, 7, 18, 12, 16, 22, 23, 14, 21, 19, 15, 13, 17, 20]);
							else
								switchNotePositions([0,1,3,2,4,5,7,6]);
							switchNoteScroll(false);
						case 2212:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2213:
							if (mania == 5)
								switchNotePositions([6, 10, 2, 5, 9, 0, 3, 1, 8, 7, 4, 11, 23, 17, 20, 21, 19, 15, 13, 12, 18, 14, 16, 22]);
							else
								switchNotePositions([1,3,2,0,5,7,6,4]);
							switchNoteScroll(false);
						case 2216:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2218:
							if (mania == 5)
								switchNotePositions([1, 2, 8, 10, 4, 5, 3, 11, 0, 6, 9, 7, 18, 12, 16, 22, 23, 14, 21, 19, 15, 13, 17, 20]);
							else
								switchNotePositions([0,1,3,2,4,5,7,6]);
							switchNoteScroll(false);
						case 2220:
							if (mania == 5)
								switchNotePositions([6, 10, 2, 5, 9, 0, 3, 1, 8, 7, 4, 11, 23, 17, 20, 21, 19, 15, 13, 12, 18, 14, 16, 22]);
							else
								switchNotePositions([1,3,2,0,5,7,6,4]);
							switchNoteScroll(false);
						case 2221:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2224:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2226:
							if (mania == 5)
								switchNotePositions([1, 2, 8, 10, 4, 5, 3, 11, 0, 6, 9, 7, 18, 12, 16, 22, 23, 14, 21, 19, 15, 13, 17, 20]);
							else
								switchNotePositions([0,1,3,2,4,5,7,6]);
							switchNoteScroll(false);
						case 2228:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2229:
							if (mania == 5)
								switchNotePositions([6, 10, 2, 5, 9, 0, 3, 1, 8, 7, 4, 11, 23, 17, 20, 21, 19, 15, 13, 12, 18, 14, 16, 22]);
							else
								switchNotePositions([1,3,2,0,5,7,6,4]);
							switchNoteScroll(false);
						case 2232:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2234:
							if (mania == 5)
								switchNotePositions([1, 2, 8, 10, 4, 5, 3, 11, 0, 6, 9, 7, 18, 12, 16, 22, 23, 14, 21, 19, 15, 13, 17, 20]);
							else
								switchNotePositions([0,1,3,2,4,5,7,6]);
							switchNoteScroll(false);
						case 2236:
							if (mania == 5)
								switchNotePositions([6, 10, 2, 5, 9, 0, 3, 1, 8, 7, 4, 11, 23, 17, 20, 21, 19, 15, 13, 12, 18, 14, 16, 22]);
							else
								switchNotePositions([1,3,2,0,5,7,6,4]);
							switchNoteScroll(false);
						case 2237:
							if (mania == 5)
								switchNotePositions([17, 18, 15, 21, 23, 20, 13, 19, 22, 16, 12, 14, 1, 4, 10, 8, 2, 0, 11, 7, 6, 5, 3, 9]);
							else
								switchNotePositions([6,7,5,4,3,2,0,1]);
							switchNoteScroll(false);
						case 2240:
							dadStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							playerStrums.forEach(function(strum:StrumNote)
							{
								strum.resetX();
							});
							modchart = ExploitationModchartType.Cyclone;
						case 2272:
							modchart = ExploitationModchartType.Jitterwave;
						case 2304:
							modchart = ExploitationModchartType.None;
							switchNoteScroll(false);
						case 2305:
							switchNoteScroll(false);
						case 2352:
							modchart = ExploitationModchartType.Cheating;
						case 2356:
							modchart = ExploitationModchartType.Unfairness;
						case 2360:
							modchart = ExploitationModchartType.Cheating;
						case 2364:
							modchart = ExploitationModchartType.Unfairness;
					}
				}
			case 'polygonized' | 'polygonized-2.5':
				switch (curBeat)
				{
					case 608:
						defaultCamZoom = 0.8;
						if (PlayState.instance.localFunny != PlayState.CharacterFunnyEffect.Recurser)
						{
							for (bgSprite in backgroundSprites)
							{
								FlxTween.tween(bgSprite, {alpha: 0}, 1);
							}
							for (bgSprite in revertedBG)
							{
								FlxTween.tween(bgSprite, {alpha: 1}, 1);
							}
							for (char in [boyfriend, gf])
							{
								if (char.animation.curAnim != null && char.animation.curAnim.name.startsWith('sing') && !char.animation.curAnim.finished)
								{
									char.animation.finishCallback = function(animation:String)
									{
										char.canDance = false;
										char == boyfriend ? char.playAnim('hey', true) : char.playAnim('cheer', true);
									}
								}
								else
								{
									char.canDance = false;
									char == boyfriend ? char.playAnim('hey', true) : char.playAnim('cheer', true);
								}
							}

							canFloat = false;
							FlxG.camera.flash(FlxColor.WHITE, 0.25);

							switchDad('dave', dad.getPosition(), false);

							FlxTween.color(dad, 0.6, dad.color, nightColor);
							if (formoverride != 'tristan-golden-glowing')
							{
								FlxTween.color(boyfriend, 0.6, boyfriend.color, nightColor);
							}
							FlxTween.color(gf, 0.6, gf.color, nightColor);

							dad.setPosition(50, 270);
							boyfriend.setPosition(843, 270);
							shx = 843;
							shy = 270;
							gf.setPosition(230, -60);
							for (char in [dad, boyfriend, gf])
							{
								repositionChar(char);
							}
							regenerateStaticArrows(0);
						}
						else
						{
							FlxG.sound.play(Paths.sound('static'), 0.1);
							curbg.loadGraphic(Paths.image('backgrounds/void/redsky', 'shared'));
							curbg.alpha = 1;
							curbg.visible = true;
							dad.animation.play('scared', true);
							dad.canDance = false;
						}
				}
			case 'memory':
				switch (curBeat)
				{
					case 416:
						switchDad('dave-annoyed', dad.getPosition());
						crazyZooming = true;
					case 672:
						crazyZooming = false;
				}
			case 'escape-from-california':
				switch (curBeat)
				{
					case 2:
						makeInvisibleNotes(true);
						defaultCamZoom += 0.2;
						subtitleManager.addSubtitle(LanguageManager.getTextString('california_sub1'), 0.02, 1.5);
					case 14:
					    subtitleManager.addSubtitle(LanguageManager.getTextString('california_sub2'), 0.04, 0.3, {subtitleSize: 60});
						FlxG.camera.fade(FlxColor.WHITE, 0.6, false, function()
						{
							FlxG.camera.fade(FlxColor.WHITE, 0, true);
						});
						FlxG.camera.shake(0.015, 0.6);
					case 16:
					    FlxG.camera.flash();
					    defaultCamZoom -= 0.2;
						makeInvisibleNotes(false);
					case 270:
						subtitleManager.addSubtitle(LanguageManager.getTextString('california_sub2'), 0.04, 0.3, {subtitleSize: 60});
						FlxG.camera.shake(0.005, 0.6);
						dad.canSing = false;
						dad.canDance = false;
						dad.playAnim('waa', true);
						dad.animation.finishCallback = function(anim:String)
						{
							dad.canSing = true;
							dad.canDance = true;
						}
					case 208:
						changeSign('1500miles');
					case 400:
						changeSign('1000miles');
					case 528:
						changeSign('500miles');
					case 712:
						FlxG.camera.fade(FlxColor.WHITE, (Conductor.crochet * 8) / 1000, false, function()
						{
							FlxG.camera.stopFX();
							FlxG.camera.flash();
						});
					case 720:
						FlxTween.num(trainSpeed, 0, 3, {ease: FlxEase.expoOut}, function(newValue:Float)
						{
							trainSpeed = newValue;
							train.animation.curAnim.frameRate = Std.int(FlxMath.lerp(0, 24, (trainSpeed / 30)));
						});
						changeSign('welcomeToGeorgia', new FlxPoint(1000, 450));

						remove(desertBG);
						remove(desertBG2);
						
					
						georgia = new BGSprite('georgia', 400, -50, Paths.image('california/geor gea', 'shared'), null, 1, 1, true);
						georgia.setGraphicSize(Std.int(georgia.width * 2.5));
						georgia.updateHitbox();
						georgia.color = nightColor;
						backgroundSprites.add(georgia);
						add(georgia);
				}
			case 'mealie':
				switch(curBeat) {
                    case 464:
						crazyZooming = true;
					case 592:
						crazyZooming = false;
				}
		}
		if (shakeCam)
		{
			gf.playAnim('scared', true);
		}

		var funny:Float = Math.max(Math.min(healthBar.value,1.9),0.1);//Math.clamp(healthBar.value,0.02,1.98);//Math.min(Math.min(healthBar.value,1.98),0.02);

		//health icon bounce but epic
		if (!inFiveNights)
		{
			iconP1.setGraphicSize(Std.int(iconP1.width + (50 * (funny + 0.1))),Std.int(iconP1.height - (25 * funny)));
			iconP2.setGraphicSize(Std.int(iconP2.width + (50 * ((2 - funny) + 0.1))),Std.int(iconP2.height - (25 * ((2 - funny) + 0.1))));
		}
		else
		{
			iconP2.setGraphicSize(Std.int(iconP2.width + (50 * funny)),Std.int(iconP2.height - (25 * funny)));
			iconP1.setGraphicSize(Std.int(iconP1.width + (50 * ((2 - funny) + 0.1))),Std.int(iconP1.height - (25 * ((2 - funny) + 0.1))));
		}

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0) {
			curBeat % (gfSpeed * 2) == 0 ? {
				iconP1.scale.set(1.1, 0.8);
				iconP2.scale.set(1.1, 1.3);

				FlxTween.angle(iconP1, -15, 0, Conductor.crochet / 1300 / gfSpeed, {ease: FlxEase.quadOut});
				FlxTween.angle(iconP2, 15, 0, Conductor.crochet / 1300 /  gfSpeed, {ease: FlxEase.quadOut});
			} : {
				iconP1.scale.set(1.1, 1.3);
				iconP2.scale.set(1.1, 0.8);

				FlxTween.angle(iconP2, -15, 0, Conductor.crochet / 1300 /  gfSpeed, {ease: FlxEase.quadOut});
				FlxTween.angle(iconP1, 15, 0, Conductor.crochet / 1300 /  gfSpeed, {ease: FlxEase.quadOut});
			}

			FlxTween.tween(iconP1, {'scale.x': 1, 'scale.y': 1}, Conductor.crochet / 1250 /  gfSpeed, {ease: FlxEase.quadOut});
			FlxTween.tween(iconP2, {'scale.x': 1, 'scale.y': 1}, Conductor.crochet / 1250 /  gfSpeed, {ease: FlxEase.quadOut});

			iconP1.updateHitbox();
			iconP2.updateHitbox();

			if (!shakeCam)
			{
				gf.dance();
			}
		}

		if(curBeat % 2 == 0)
		{
			if (!boyfriend.animation.curAnim.name.startsWith("sing") && boyfriend.canDance && (boyfriend.animation.curAnim.name == "hit" ? boyfriend.animation.curAnim.finished : true) && (boyfriend.animation.curAnim.name == "dodge" ? boyfriend.animation.curAnim.finished : true))
			{
				boyfriend.dance();
				if (darkLevels.contains(curStage) && (SONG.song.toLowerCase() != "polygonized" || (SONG.song.toLowerCase() == "polygonized" && curBeat >= 608)) && formoverride != 'tristan-golden-glowing' && bfTween == null)
				{
					boyfriend.color = nightColor;
				}
				else if(sunsetLevels.contains(curStage) && bfTween == null)
				{
					boyfriend.color = sunsetColor;
				}
				else if (bfTween == null)
				{
					boyfriend.color = FlxColor.WHITE;
				}
				else
				{
					if (!bfTween.active && !bfTween.finished)
					{
						bfTween.active = true;
					}
					boyfriend.color = bfTween.color;
				}
				if (darkLevels.contains(curStage) && (SONG.song.toLowerCase() != "polygonized-2.5" || (SONG.song.toLowerCase() == "polygonized-2.5" && curBeat >= 608)) && formoverride != 'tristan-golden-glowing' && bfTween == null)
					{
						boyfriend.color = nightColor;
					}
					else if(sunsetLevels.contains(curStage) && bfTween == null)
					{
						boyfriend.color = sunsetColor;
					}
					else if (bfTween == null)
					{
						boyfriend.color = FlxColor.WHITE;
					}
					else
					{
						if (!bfTween.active && !bfTween.finished)
						{
							bfTween.active = true;
						}
						boyfriend.color = bfTween.color;
					}
			}
		}

	}
	function gameOver()
	{
		#if windows
		if (window != null)
		{
			expungedWindowMode = false;
			window.close();
			//x,y, width, height
			FlxTween.tween(Application.current.window, {x: windowProperties[0], y: windowProperties[1], width: windowProperties[2], height: windowProperties[3]}, 1, {ease: FlxEase.circInOut});

		}
		#end
		var deathSkinCheck = formoverride == "bf" || formoverride == "none" ? SONG.player1 : isRecursed ? boyfriend.curCharacter : formoverride;
		var chance = FlxG.random.int(0, 99);
		if (chance <= 2 && eyesoreson)
		{
			openSubState(new TheFunnySubState(deathSkinCheck));
			#if desktop
				DiscordClient.changePresence("GAME OVER -- "
				+ SONG.song
				+ " ("
				+ storyDifficultyText
				+ ") ",
				"\n what", iconRPC);
			#end
		}
		else
		{
			#if desktop
			if (SONG.song.toLowerCase() == 'exploitation')
			{
				var expungedLines:Array<String> = 
				[
					'i found you.', 
					"i can see you.", 
					'HAHAHHAHAHA', 
					"punishment day is here, this one is removing you.",
					"got you.",
					"try again, if you dare.",
					"nice try.",
					"i could do this all day.",
					"do that again. i like watching you fail."
				];

				var path = CoolSystemStuff.getTempPath() + "/HELLO.txt";

				var randomLine = new FlxRandom().int(0, expungedLines.length);
				File.saveContent(path, expungedLines[randomLine]);
				#if windows
				Sys.command("start " + path);
				#elseif linux
				Sys.command("xdg-open " + path);
				#else
				Sys.command("open " + path);
				#end
			}
			#end

			if (SONG.song.toLowerCase() == 'recursed')
			{
				cancelRecursedCamTween();
			}
			
			if (!inFiveNights)
			{
				if (funnyFloatyBoys.contains(boyfriend.curCharacter))
				{
					openSubState(new GameOverPolygonizedSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y, deathSkinCheck));
				}
				else
				{
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y, deathSkinCheck));
				}
			}
			else
			{
				if (powerDown != null)
				{
					powerDown.stop();
				}
				openSubState(new GameOverFNAF());
			}
			#if desktop
				DiscordClient.changePresence("GAME OVER -- "
				+ SONG.song
				+ " ("
				+ storyDifficultyText
				+ ") ",
				"\nAcc: "
				+ truncateFloat(accuracy, 2)
				+ "% | Score: "
				+ songScore
				+ " | Misses: "
				+ misses, iconRPC);
			#end
		}
		
	}

	function eatShit(ass:String):Void
	{
		if (dialogue[0] == null)
		{
			trace(ass);
		}
		else
		{
			trace(dialogue[0]);
		}
	}

	public function addSplitathonChar(char:String):Void
	{
		boyfriend.stunned = true; //hopefully this stun stuff should prevent BF from randomly missing a note
		
		switchDad(char, new FlxPoint(300, 450), false);
		repositionChar(dad);

		boyfriend.stunned = false;
	}

	public function splitathonExpression(character:String, expression:String):Void
	{
		boyfriend.stunned = true;
		if(splitathonCharacterExpression != null)
		{
			dadGroup.remove(splitathonCharacterExpression);
		}
		switch (character)
		{
			case 'dave':
				splitathonCharacterExpression = new Character(0, 225, 'dave-splitathon');
			case 'bambi':
				splitathonCharacterExpression = new Character(0, 580, 'bambi-splitathon');
		}
		dadGroup.insert(dadGroup.members.indexOf(dad), splitathonCharacterExpression);

		splitathonCharacterExpression.color = getBackgroundColor(curStage);
		splitathonCharacterExpression.canDance = false;
		splitathonCharacterExpression.playAnim(expression, true);
		boyfriend.stunned = false;
	}

	public function preload(graphic:String) //preload assets
	{
		if (boyfriend != null)
		{
			boyfriend.stunned = true;
		}
		var newthing:FlxSprite = new FlxSprite(9000,-9000).loadGraphic(Paths.image(graphic));
		add(newthing);
		remove(newthing);
		if (boyfriend != null)
		{
			boyfriend.stunned = false;
		}
	}
	public function preload2(graphic:String) //preload assets
	{
		if (boyfriend != null)
		{
			boyfriend.stunned = true;
		}
		var newthing:FlxSprite = new FlxSprite(9000,-9000).loadGraphic(graphic);
		add(newthing);
		remove(newthing);
		if (boyfriend != null)
		{
			boyfriend.stunned = false;
		}
	}
	public function repositionChar(char:Character)
	{
		char.x += char.globalOffset[0];
		char.y += char.globalOffset[1];
	}
	function updateSpotlight(bfSinging:Bool)
	{
		var curSinger = bfSinging ? boyfriend : dad;

		if (lastSinger != curSinger)
		{
			gf.canDance = false;
			bfSinging ? gf.playAnim("singRIGHT", true) : gf.playAnim("singLEFT", true);
			gf.animation.finishCallback = function(anim:String)
			{
				gf.canDance = true;
			}

			var positionOffset:FlxPoint = new FlxPoint(0,-150);

			switch (curSinger.curCharacter)
			{
				case 'bambi-new':
					positionOffset.x = -25;
					positionOffset.y += -70;
				case 'bf-pixel':
					positionOffset.y += -225;
			}
			var targetPosition = new FlxPoint(curSinger.getGraphicMidpoint().x - spotLight.width / 2 + positionOffset.x, curSinger.getGraphicMidpoint().y + curSinger.frameHeight / 2 - (spotLight.height) - positionOffset.y);
			
			if (SONG.song.toLowerCase() == 'indignancy')
			{
				targetPosition.y += 80;
			}

			FlxTween.tween(spotLight, {x: targetPosition.x, y: targetPosition.y}, 0.66, {ease: FlxEase.circOut});
			lastSinger = curSinger;
		}
	}
	function switchToNight()
	{
		var bedroomSpr = BGSprite.getBGSprite(backgroundSprites, 'bg');
		var baldiSpr = BGSprite.getBGSprite(backgroundSprites, 'baldi');
		var rubySpr = BGSprite.getBGSprite(backgroundSprites, 'ruby');

		bedroomSpr.loadGraphic(Paths.image('backgrounds/bedroom/night/bg'));
		baldiSpr.loadGraphic(Paths.image('backgrounds/bedroom/night/bed'));
		if (rubySpr != null)
		{
			rubySpr.loadGraphic(Paths.image('backgrounds/bedroom/night/ruby'));
		}
		curStage = 'bedroomNight';

		switchDad('playrobot-shadow', dad.getPosition(), true, false);
		tristanInBotTrot.animation.play('idleNight');
		
		if (formoverride != 'tristan-golden') {
		    boyfriend.color = getBackgroundColor(curStage);
		}

		if (formoverride == 'tristan-golden' || formoverride == 'tristan-golden-glowing') {
			boyfriend.color = FlxColor.WHITE;
            switchBF('tristan-golden-glowing', boyfriend.getPosition(), true, true);
		}
	}
	function nofriendAttack()
	{
		dad.canDance = false;
		dad.canSing = false;
		dad.playAnim('attack', true);
		var runSfx = new FlxSound().loadEmbedded(Paths.soundRandom('fiveNights/run', 1, 2, 'shared'));
		runSfx.play();
	}
	function sixAM()
	{
		FlxG.sound.music.volume = 1;
		vocals.volume = 1;
		camHUD.alpha = 1;

		FlxG.camera.flash(FlxColor.WHITE, 0.5);
		black = new FlxSprite(0, 0).makeGraphic(2560, 1440, FlxColor.BLACK);
		black.screenCenter();
		black.scrollFactor.set();
		black.cameras = [camHUD];
		add(black);

		var sixAM:FlxText = new FlxText(0, 0, 0, "6 AM", 90);
		sixAM.setFormat(Paths.font('fnaf.ttf'), 90, FlxColor.WHITE, CENTER);
		sixAM.antialiasing = false;
		sixAM.scrollFactor.set();
		sixAM.screenCenter();
		sixAM.cameras = [camHUD];
		sixAM.alpha = 0;
		add(sixAM);

		FlxTween.tween(sixAM, {alpha: 1}, 1);

		var crowdSmall = new FlxSound().loadEmbedded(Paths.sound('fiveNights/CROWD_SMALL_CHIL_EC049202', 'shared'));
		crowdSmall.play();
	}
	public function getCamZoom():Float
	{
		return defaultCamZoom;
	}
	public static function resetShader()
	{
		PlayState.instance.shakeCam = false;
		PlayState.instance.camZooming = false;
		#if SHADERS_ENABLED
		screenshader.shader.uampmul.value[0] = 0;
		screenshader.Enabled = false;
		#end
	}

	function sectionStartTime(section:Int):Float
	{
		var daBPM:Float = SONG.bpm;
		var daPos:Float = 0;
		for (i in 0...section)
		{
			daPos += 4 * (1000 * 60 / daBPM);
		}
		return daPos;
	}
	function switchNoteScroll(cancelTweens:Bool = true)
	{
		switch (scrollType)
		{
			case 'upscroll':
				strumLine.y = DOWNSCROLL_Y;
				scrollType = 'downscroll';
			case 'downscroll':
				strumLine.y = UPSCROLL_Y;
				scrollType = 'upscroll';
		}
		for (strumNote in strumLineNotes)
		{
			if (cancelTweens)
			{
				FlxTween.completeTweensOf(strumNote);
			}
			strumNote.angle = 0;
			
			FlxTween.angle(strumNote, strumNote.angle, strumNote.angle + 360, 0.4, {ease: FlxEase.expoOut});
			FlxTween.tween(strumNote, {y: strumLine.y}, 0.6, {ease: FlxEase.backOut});
		}
	}

	function switchNoteSide()
	{
		for (i in 0...Main.keyAmmo[mania])
		{
			var curOpponentNote = dadStrums.members[i];
			var curPlayerNote = playerStrums.members[i];

			FlxTween.tween(curOpponentNote, {x: curPlayerNote.x}, 0.6, {ease: FlxEase.expoOut, startDelay: 0.01 * i});
			FlxTween.tween(curPlayerNote, {x: curOpponentNote.x}, 0.6, {ease: FlxEase.expoOut, startDelay: 0.01 * i});
		}
		switchSide = !switchSide;
	}

	function switchNotePositions(order:Array<Int>)
	{
		var positions:Array<Float> = [];
		for (i in 0...Main.keyAmmo[mania])
		{
			var curNote = playerStrums.members[i];
			positions.push(curNote.baseX);
		}
		for (i in 0...Main.keyAmmo[mania])
		{
			var curNote = dadStrums.members[i];
			positions.push(curNote.baseX);
		}
		for (i in 0...Main.keyAmmo[mania])
		{
			var curOpponentNote = dadStrums.members[i];
			var curPlayerNote = playerStrums.members[i];

			FlxTween.tween(curOpponentNote, {x: positions[order[i + playerStrumAmount]]}, 0.6, {ease: FlxEase.expoOut, startDelay: 0.01 * i});
			FlxTween.tween(curPlayerNote, {x: positions[order[i]]}, 0.6, {ease: FlxEase.expoOut, startDelay: 0.01 * i});
		}
		switchSide = !switchSide;
	}

	function switchDad(newChar:String, position:FlxPoint, reposition:Bool = true, updateColor:Bool = true)
	{
		if (reposition)
		{
			position.x -= dad.globalOffset[0];
			position.y -= dad.globalOffset[1];
		}
		dadGroup.remove(dad);
		dad = new Character(position.x, position.y, newChar, false);
		dadGroup.add(dad);
		if (FileSystem.exists(Paths.image('ui/iconGrid/${dad.curCharacter}', 'preload')))
		{
			iconP2.changeIcon(dad.curCharacter);
		}
		healthBar.createFilledBar(dad.barColor, boyfriend.barColor);
		
		if (updateColor)
		{
			dad.color = getBackgroundColor(curStage);
		}
		if (reposition)
		{
			repositionChar(dad);
		}
	}
	function switchBF(newChar:String, position:FlxPoint, reposition:Bool = true, updateColor:Bool = true)
	{
		if (reposition)
		{
			position.x -= boyfriend.globalOffset[0];
			position.y -= boyfriend.globalOffset[1];
		}
		bfGroup.remove(boyfriend);
		boyfriend = new Boyfriend(position.x, position.y, newChar);
		bfGroup.add(boyfriend);
		if (FileSystem.exists(Paths.image('ui/iconGrid/${boyfriend.curCharacter}', 'preload')))
		{
			iconP1.changeIcon(boyfriend.curCharacter);
		}
		healthBar.createFilledBar(dad.barColor, boyfriend.barColor);
		
		if (updateColor)
		{
			boyfriend.color = getBackgroundColor(curStage);
		}
		if (reposition)
		{
			repositionChar(boyfriend);
		}
	}
	function switchGF(newChar:String, position:FlxPoint, reposition:Bool = true, updateColor:Bool = true)
	{
		if (reposition)
		{
			position.x -= gf.globalOffset[0];
			position.y -= gf.globalOffset[1];
		}
		gfGroup.remove(gf);
		gf = new Character(position.x, position.y, newChar);
		gfGroup.add(gf);
		
		if (updateColor)
		{
			gf.color = getBackgroundColor(curStage);
		}
		if (reposition)
		{
			repositionChar(gf);
		}
	}

	function makeInvisibleNotes(invisible:Bool)
	{
		if (invisible)
		{
			for (strumNote in strumLineNotes)
			{
				FlxTween.cancelTweensOf(strumNote);
				FlxTween.tween(strumNote, {alpha: 0}, 1);
			}
		}
		else
		{
			for (strumNote in strumLineNotes)
			{
				FlxTween.cancelTweensOf(strumNote);
				FlxTween.tween(strumNote, {alpha: 1}, 1);
			}
		}
	}
	function changeDoorState(closed:Bool)
	{
		doorClosed = closed;
		doorChanging = true;
		FlxG.sound.play(Paths.sound('fiveNights/doorInteract', 'shared'), 1);
		if (doorClosed)
		{
			doorButton.loadGraphic(Paths.image('fiveNights/btn_doorClosed'));
			powerMeter.loadGraphic(Paths.image('fiveNights/powerMeter_2'));
			door.animation.play('doorShut');
			
			powerDrainer = 3;
		}
		else
		{
			doorButton.loadGraphic(Paths.image('fiveNights/btn_doorOpen'));
			powerMeter.loadGraphic(Paths.image('fiveNights/powerMeter'));
			door.animation.play('doorOpen');

			powerDrainer = 1;
		}
		door.animation.finishCallback = function(animation:String)
		{
			doorChanging = false;
		}
	}
	function changeSign(asset:String, ?position:FlxPoint)
	{
		sign.loadGraphic(Paths.image('california/$asset', 'shared'));
		if (position != null)
		{
			sign.setPosition(position.x, position.y);
		}
		else
		{
			sign.setPosition(FlxG.width + sign.width, 450);
		}
	}

	function showhphud()
	{
		for (elem in [judgementCounter]) {
			if (elem != null) {
				FlxTween.tween(elem, {alpha: 1}, Conductor.crochet / 250, {ease: FlxEase.circOut});
			   }  }
	
					   for (elem in [healthBar, iconP1, iconP2, healthBarBG]) {
							   if (elem != null) {
			   }  }
	
			for (delem in [healthBar, iconP1, iconP2, healthBarBG]) {
				if (delem != null) {
					FlxTween.tween(delem, {y: (FlxG.save.data.downscroll ?  delem.y + 490 :  delem.y - 510)}, Conductor.crochet / 250, {ease: FlxEase.circOut});
		
				}  }
	}
	function hidehphud()
	{
		for (elem in [healthBar, iconP1, iconP2, healthBarBG, judgementCounter]) {
			if (elem != null) {
				elem.alpha = 1;
			}  
		}
		for (delem in [healthBar, iconP1, iconP2, healthBarBG,]) {
			if (delem != null) {
				(FlxG.save.data.downscroll ?  delem.y -= 500 :  delem.y += 500);
			}  
		}
	
	}

	var ratingString:String;
	var ratingPercent:Float;
	var ratingFC:String;
	function RecalculateRating() {
		ratingPercent = songScore / ((songHits + misses) * 350);
		if(!Math.isNaN(ratingPercent) && ratingPercent < 0) ratingPercent = 0;

		if(Math.isNaN(ratingPercent)) {
			ratingString = '?';
		} else if(ratingPercent >= 1) {
			ratingString = ratingStuff[ratingStuff.length-1][0]; //Uses last string
		} else {
			for (i in 0...ratingStuff.length-1) {
				if(ratingPercent < ratingStuff[i][1]) {
					ratingString = ratingStuff[i][0];
					break;
				}
			}
		}

		// Rating FC
		ratingFC = "";
		if (sicks > 0) ratingFC = "SFC";
		if (goods > 0) ratingFC = "GFC";
		if (bads > 0 || shits > 0) ratingFC = "FC";
		if (misses > 0 && misses < 10) ratingFC = "SDCB";
		else if (misses >= 10) ratingFC = "Clear";
	}		

	function popupWindow()
	{
		var screenwidth = Application.current.window.display.bounds.width;
		var screenheight = Application.current.window.display.bounds.height;

		// center
		Application.current.window.x = Std.int((screenwidth / 2) - (1280 / 2));
		Application.current.window.y = Std.int((screenheight / 2) - (720 / 2));
		Application.current.window.width = 1280;
		Application.current.window.height = 720;

		window = Application.current.createWindow({
			title: "expunged.dat",
			width: 800,
			height: 800,
			borderless: true,
			alwaysOnTop: true
		});

		window.stage.color = 0x00010101;
		@:privateAccess
		window.stage.addEventListener("keyDown", FlxG.keys.onKeyDown);
		@:privateAccess
		window.stage.addEventListener("keyUp", FlxG.keys.onKeyUp);
		#if linux
		//testing stuff
		window.stage.color = 0xff000000;
		trace('BRAP');
		#end
		PlatformUtil.getWindowsTransparent();

		preDadPos = dad.getPosition();
		dad.x = 0;
		dad.y = 0;

		FlxG.mouse.useSystemCursor = true;

		generateWindowSprite();

		expungedScroll.scrollRect = new Rectangle();
		window.stage.addChild(expungedScroll);
		expungedScroll.addChild(expungedSpr);
		expungedScroll.scaleX = 0.5;
		expungedScroll.scaleY = 0.5;

		expungedOffset.x = Application.current.window.x;
		expungedOffset.y = Application.current.window.y;

		dad.visible = false;

		var windowX = Application.current.window.x + ((Application.current.window.display.bounds.width) * 0.140625);

		windowSteadyX = windowX;

		FlxTween.tween(expungedOffset, {x: -20}, 2, {ease: FlxEase.elasticOut});

		FlxTween.tween(Application.current.window, {x: windowX}, 2.2, {
			ease: FlxEase.elasticOut,
			onComplete: function(tween:FlxTween)
			{
				ExpungedWindowCenterPos.x = expungedOffset.x;
				ExpungedWindowCenterPos.y = expungedOffset.y;
				expungedMoving = false;
			}
		});

		Application.current.window.onClose.add(function()
		{
			if (window != null)
			{
				window.close();
			}
		}, false, 100);

		Application.current.window.focus();
		expungedWindowMode = true;

		@:privateAccess
		lastFrame = dad._frame;
	}

	function generateWindowSprite()
	{
		var m = new Matrix();
		m.translate(0, 0);
		expungedSpr.graphics.beginBitmapFill(dad.pixels, m);
		expungedSpr.graphics.drawRect(0, 0, dad.pixels.width, dad.pixels.height);
		expungedSpr.graphics.endFill();
	}
	
}
enum ExploitationModchartType
{
	None; Cheating; Figure8; ScrambledNotes; Cyclone; Unfairness; Jitterwave; PingPong; Sex;
}

enum CharacterFunnyEffect
{
	None; Dave; Bambi; Tristan; Exbungo; Recurser; Shaggy;
}
