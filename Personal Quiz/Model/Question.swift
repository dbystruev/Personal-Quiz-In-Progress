//
//  Question.swift
//  Personal Quiz
//
//  Created by Denis Bystruev on 06/12/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вы любите бывать в компании.  Вы всегда окружены друзьями.  Вам нравиться играть и быть лучшим другом для всех."
        case .cat:
            return "Вы гуляете сами по себе.  Вам нравится свобода и самостоятельность."
        case .rabbit:
            return "Вам нравится всё мягкое.  Вы здоровы и полны энергии."
        case .turtle:
            return "Вы мудры не по годам.  Медленный и вдумчивый выигрывает гонку.  Тише едешь, дальше будешь."
        }
    }
}
