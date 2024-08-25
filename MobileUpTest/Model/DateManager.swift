//
//  DateManager.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation

final class DateManager {
    static func getDate(from unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy" // Задаем формат: день, месяц и год
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем регион для русского языка

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
