//
//  Fixtures..swift
//  MarvelComicsInfoTests
//
//  Created by Kenny Liao on 10/10/21.
//

import Foundation
@testable import MarvelComicsInfo

class Fixtures {
    
    class func mockComics() -> [ComicData] {
        let comic1 = ComicData(
            id: 2,
            title: "Pulse (2004) #6",
            description: "PART 1 (OF 5)\r<br>Jessica Jones and Luke Cage's lives have been destroyed by the events of the Secret War, so what is Jessica going to do about it?  Fans of Secret War - feel The Pulse as it pounds out more gritty intrigue even as it welcomes a new artist: award-winning comics superstar Brent (RISING STARS, ASTRO CITY) Anderson!  \r<br>Guest-starring: Captain America, Luke Cage, Iron Fist, Nick Fury and many, many more.\r<br>",
            thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/30/56538fd257915", ext: "jpg")
        )
        
        let comic2 = ComicData(
            id: 4,
            title: "Rogue (2004) #5",
            description: "GOING ROGUE PART 5 The love triangle between Rogue, Gambit and the mysterious stranger who's been both helping and hindering Rogue in her quest heats up! But what happens when Rogue's search begins to put the life of someone she loves in danger?\nGOING ROGUE PART 5 The love triangle between Rogue, Gambit and the mysterious stranger who's been both helping and hindering Rogue in her quest heats up! But what happens when Rogue's search begins to put the life of someone she loves in danger?\n",
            thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/a0/58c9bae62316f", ext: "jpg")
        )
        
        let comic3 = ComicData(
            id: 5,
            title: "Spectacular Spider-Man (2003) #21",
            description: "PART 1 (OF 1)\r<br>GUEST-STARRING THE FANTASTIC FOUR, DOCTOR STRANGE, THE BLACK CAT AND THE ANGEL! Ben Grimm's all-night poker games have become legendary among the super hero set, and for the first time Spider-Man has been asked to join the table! But when the Kingpin unexpectedly deals himself in, the stakes are raised! Can the wall-crawler come out on top in this celebrity poker showdown?\r<br>",
            thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/8/60/5c5b207e022ca", ext: "jpg")
        )
        
        let comic4 = ComicData(
            id: 8,
            title: "Exiles (2001) #54",
            description: "\"CHAIN LIGHTNING\" STAND-ALONE ISSUE!\r<br>A seemingly trivial, low-key mission spirals into a cataclysmic, universe-shattering disaster...all because of a Danish?! The Exiles' most hilarious adventure yet! \r<br>",
            thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/60/57eada6a70e8c", ext: "jpg")
        )
        
        return [comic1, comic2, comic3, comic4]
    }
    
    class func comicsList() -> ComicsList {
        return ComicsList(
            offset: 0,
            limit: 5,
            total: 4,
            count: 4,
            results: Fixtures.mockComics()
        )
    }
    
    class func comicDetail(_ comicId: String) -> ComicDetail {
        let comics = Fixtures.mockComics()
        let data = comics.filter {
            "\($0.id)" == comicId
        }        
        return ComicDetail(offset: 0, limit: 5, total: 1, count: 1, results: data)
    }
}
