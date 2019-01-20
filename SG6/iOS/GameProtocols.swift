//
//  GameProtocols.swift
//  SG6
//
//  Created by terrybfoster on 5/12/18.
//  Copyright © 2018 terrybfoster. All rights reserved.
//

import UIKit
//********************************************************************
protocol mainMenuDelegate: class
{
    func mainMenuSelectMap()
    func mainMenuGenerateMap()
    func mainMenuSolveMap()
}
//********************************************************************
protocol selectMapDelegate: class
{
    func selectMap()
    func selectMapCloses()
}
//********************************************************************
protocol gameControlDelegate: class
{
    func gameControlGameState(state: gameState)
}
//********************************************************************
protocol gameMenuDelegate: class
{
    func gameMenuQuitsGame()
    func gameMenuPhoto()
}
//********************************************************************
