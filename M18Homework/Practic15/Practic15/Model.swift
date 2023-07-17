//
//  Model.swift
//  Practic15
//
//  Created by Даниил Циркунов on 09.03.2023.
//

//{
//    errorMessage = "";
//    expression = Fuu;
//    results =     (
//                {
//            description = "2022\U2013 TV Series Seiichiro Yamashita, Saori Oonishi";
//            id = tt16231800;
//            image = "https://m.media-amazon.com/images/M/MV5BNmM1ZjM3ZWItN2UwNC00YjEwLTkzZjMtZDdjNWU5NWMyYmViXkEyXkFqcGdeQXVyMzgxODM4NjM@._V1_Ratio0.6757_AL_.jpg";
//            resultType = Title;
//            title = "More Than a Married Couple, But Not Lovers.";
//        },

import Foundation

struct Model: Codable {
    let errorMessage: String?
    let expression: String?
    let results: [Film]?
    let searchType: String?
}

struct Film: Codable {
    let description: String
    let id: String?
    let image: String
    let resultType: String?
    let title: String
}
