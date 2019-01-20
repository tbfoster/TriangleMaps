//
//  Enumerations.swift
//  Alienable Rights
//
//  Created by terrybfoster on 6/14/18.
//  Copyright © 2018 terrybfoster. All rights reserved.
//

import Foundation
//**********************************************************
enum gameState
{
    case
    mainMenu,           // Main Menu
    subMenu,            // Sub Menus
    staging,            // Staging saved games, need time to load them
    run                // Run - all functions active
}
//**********************************************************
// Order through g6Explosion is important for 
enum gameTypes: Int
{
    case
    g1=0, g2, g3, g4, g5, g6,                       // Ground Attack
    d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10,    // Defenses
    dBase,                                          // Defense Base Images
    groundTotal,                                    // Total of all ground troups active
    highActive,                                     // Highest active count of ground troops to prevent too many at once
    none                                            // At times, there is no game type such as as adding the first defense
}
//**********************************************************
enum gameTextureTypes: Int
{
    case
    g1=0, g2, g3, g4, g5, g6,                       // Ground Attack
    d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10,    // Defenses, top image
    defenseBase, barrelColor,                       // Defense Base Image and barrel colors
    themeRiserBtn, themeAddDefenseBtn,              // Themed Buttons
    themeUpgradeDefenseBtn, themeEnemies,
    g1ExplosionColor, g2ExplosionColor, g3ExplosionColor, g4ExplosionColor, g5ExplosionColor, g6ExplosionColor,
    d1ProjectileColor, d2ProjectileColor, d3ProjectileColor, d4ProjectileColor, d5ProjectileColor,
    d6ProjectileColor, d7ProjectileColor, d8ProjectileColor, d9ProjectileColor, d10ProjectileColor
}
//**********************************************************
enum menuButtonTypes: Int
{
    case
    // Main Menu Buttons
    btnNewGame = 1, btnSavedGame, btnHighScores, btnSkins, btnPlayer, btnHelp,
    btnHudMenu,
    btnHome, btnBack, btnNext, btnPrev, btnDone, btnGotIt, btnKeepShowing, btnNoAds, btnBuyMaps, btnBuyAll,
    btnAddDefense, btnUpgradeDefense, btnRemove, btnRiser, btnWarp, btnDefaults, btnPhotos,
    btnZoomIn, btnZoomOut, btnAutoUpgradeOn, btnAutoUpgradeOff, btnAutoResumeOn, btnAutoResumeOff,
    btnEasy, btnMid, btnHard, btnEasyNA, btnMidNA, btnHardNA,
    btnInGame, btnSetDefaults, btnAuto,
    btnAchievement1, btnAchievement2, btnAchievement3, btnAchievement4, btnAchievement5, btnAchievement6,
    btnAchievement7, btnAchievement8, btnAchievement9, btnAchievement10, btnAchievement11, btnAchievement12, btnAchievement13,
    btnEnemySkin1, btnEnemySkin2,
    btnDefenseSkin1, btnDefenseSkin2,
    btnClock1, btnClock2, btnClock3, btnClock4, btnClock5,
    // Sliders
    sliderRed,
    sliderGreen,
    sliderBlue,
    // Labels
    lblAchievement1, lblAchievement2, lblAchievement3, lblAchievement4, lblAchievement5, lblAchievement6, lblAchievement7,
    lblAchievement8, lblAchievement9, lblAchievement10, lblAchievement11, lblAchievement12, lblAchievement13,
    lblHelpNotes,
    lblNewFeaturesNotes,
    lblBackDrop,
    lblHud,
    lblWave,
    lblTitle,
    lblHighScore1, lblHighScore2, lblHighScore3, lblHighScore4, lblHighScore5,
    // Info Messages
    infoNoInventory, infoNoFunding, infoDefensesMaxed, infoAddDefense, infoUpgradeDefense,
    // Images
    imageCA9Background,
    imageCA9MktAdd,
    imageBackground,
    // Display Only Labels and Buttons
    lblDisplayTitle, btnDisplayBtnBack,  btnDisplayBtnHome, btnDisplayBtnEnabled, btnDisplayBtnDisabled,
    // Page Control
    pageControl,
    // Percentage Indicators
    displayPercentIndicator, resumeIndicator, zoomLevelIndicator, playerIndicator,
    // Scroll Views
    playerScrollView,
    //**********************************************************
    // Save defaults keys
    //**********************************************************
    // Colors
    //keyMenuBackgroundColor,
    keyInfoTextColor,
    // Achievements
    keyEasyPlayed, keyEasyWon, keyEasyNoEscapes, keyMidPlayed, keyMidWin, keyMidNoEscapes, keyHardPlayed, keyHardWin, keyHardNoEscapes, keyWarpToVictory,
    keyBuyAll, keyBuyNoAds, keyBuyNewMaps,
    // Saved game vars
    keySavedGame, keyWave, keyMoney, keyEscapes, keyPerfectWaves, keyDefenses, keyDefenseTypes, keyHighScores,
    keyShowFeatures, keyShowHelp,
    keyPlayerLevel,
    keyAttackTheme, keyDefenseTheme,
    keyAutoUpgrade, keyAutoResume,
    keyZoomLevel
}
//**********************************************************
enum panelTypes
{
    case
    normal,         // Normal empty space on board
    entry,          // Entry Panel
    exit,           // Exit panel
    none,           // Panel is not active and not displayed
    
    path            // Only for materials display, not part of panels
}
//**********************************************************
// View Controller
//**********************************************************
enum dragModes
{
    case
    none, strafe, drag
}
//**********************************************************
enum selectMenuTypes
{
    case menuMain,
    menuGame,
    menuSelectMap
}
//**********************************************************
// UIDesigner
//**********************************************************
enum alignText
{
    case
    bottom,
    top,
    center
}
//**********************************************************
enum alignHorizontol
{
    case
    left,
    right,
    center,
    rightOf,
    leftOf,
    leftInside,
    leftEven,
    rightInside
}
//**********************************************************
enum alignVertical
{
    case
    top,
    bottom,
    center,
    below,
    above,
    aboveInside,
    belowInside,
    topMargin
}
//********************************************************************
