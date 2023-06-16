//
//  DateFormatComponent.swift
//  WeatherApp
//
//  Created by Sahassawat on 16/6/2566 BE.
//

import Foundation

enum DateFormat: String {
    case day = "dd"
    case month = "MMMM"
    case year = "yyyy"
    case hour = "h'h'"
    case ddmmyyyy = "dd/MM/yyyy"
    case fullDateTimeTH = "dd/MM/yyyy HH:mm:ss"
    case serviceDateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    case receipt = "dd MMMM yyyy - HH:mm:ss น."
    case home = "dd MMMM yyyy"
    case transactionAPI = "yyyy/MM/dd"
    case homeCollectionCell = "dd MMM yyyy"
    case cbsRequestIDComponent = "HHmmssSSS"
    case bookingDisplaySelectedDate = "dd MMM yy"
    case monthYearWord = "MMMM yyyy"
    case monthYearShort = "yyyy-MM"
    case timeOnly = "HH:mm"
    case transactionDateTimeZoneAPI = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case transactionDateTimeAPI = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    case transactionDate = "dd MMM yy HH:mm:ss น."
    case notificationList = "dd MMM yy, HH:mm น."
    case loginOnBoard = "dd MM yyyy"
    case mdCardAPI = "yyyy-MM-dd"
    case doctorAPI = "yyyyMMdd"
    case random = "ddmmyyyyHHmmss"
    case notificationDate = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case timeAPIWeather = "yyyy-MM-dd HH:mm:ss"
    case ccmeDate = "d MMM yyyy"
    case mdCardPaymentExpire = "dd MMM yy, HH:mm:ss น."
}

protocol CurrentDateFormatter {
    func getCurrentDate(destinationPattern: DateFormat) -> String
}

struct DateFormatComponent: CurrentDateFormatter {

    private var dateString: String!
    static let shareInstance = DateFormatComponent()

    func format(dateString: String, sourcePattern: DateFormat, destinationPattern: DateFormat, localeType: String = Constants.localeEn) -> String {
        var formatedDate: String = ""
        if !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = sourcePattern.rawValue
            var locale = Locale(identifier: localeType)
            dateFormatter.locale = locale
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Bangkok")

            guard let dateFormat = dateFormatter.date(from: dateString) else {
                return formatedDate
            }

            if LanguageComponent.currentLanguage() == LanguageComponent.thai {
                dateFormatter.dateFormat = destinationPattern.rawValue
                let gregorianCalendar = Calendar(identifier: Calendar.Identifier.buddhist)
                locale = Locale(identifier: Constants.localeTh)
                dateFormatter.calendar = gregorianCalendar
                dateFormatter.locale = locale
                formatedDate = dateFormatter.string(from: dateFormat).uppercased()
            } else {
                dateFormatter.dateFormat = destinationPattern.rawValue
                formatedDate = dateFormatter.string(from: dateFormat).uppercased()
            }
        }
        return formatedDate
    }
    
    func format(dateString: String,
                sourcePattern: DateFormat,
                destinationPattern: DateFormat,
                sourceLocaleType: String = Constants.localeEn,
                destinationLocaleType: String = Constants.localeEn,
                destinationCalendar: Calendar = Calendar(identifier: .iso8601)) -> String {
        var formatedDate: String = ""
        if !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = sourcePattern.rawValue
            var locale = Locale(identifier: sourceLocaleType)
            dateFormatter.locale = locale
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Bangkok")

            guard let dateFormat = dateFormatter.date(from: dateString) else {
                return formatedDate
            }

            dateFormatter.dateFormat = destinationPattern.rawValue
            let gregorianCalendar = destinationCalendar
            locale = Locale(identifier: destinationLocaleType)
            dateFormatter.calendar = gregorianCalendar
            dateFormatter.locale = locale
            formatedDate = dateFormatter.string(from: dateFormat).uppercased()
        }
        return formatedDate
    }

    func format(sourceDate: Date, destinationPattern: DateFormat) -> String {
        var formatedDate: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = destinationPattern.rawValue
        var locale = Locale(identifier: Constants.localeEn)
        dateFormatter.locale = locale

        if  LanguageComponent.currentLanguage() == Constants.localeTh {
            let gregorianCalendar = Calendar(identifier: Calendar.Identifier.buddhist)
            locale = Locale(identifier: Constants.localeTh)
            dateFormatter.calendar = gregorianCalendar
            dateFormatter.locale = locale
        }

        formatedDate = dateFormatter.string(from: sourceDate).uppercased()
        return formatedDate
    }

    func formatWithLocal(dateString: String, sourcePattern: DateFormat,
                         sourceLanguageComponent: String,
                         destinationPattern: DateFormat,
                         destinationLanguageComponent: String) -> String! {
        var formatedDate: String = ""
        if !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = sourcePattern.rawValue
            let sourceLocale = Locale(identifier: sourceLanguageComponent)
            dateFormatter.locale = sourceLocale

            guard let dateFormat = dateFormatter.date(from: dateString) else {
                return formatedDate
            }

            dateFormatter.dateFormat = destinationPattern.rawValue
            let destinationLocal = Locale(identifier: destinationLanguageComponent)
            dateFormatter.locale = destinationLocal
            formatedDate = dateFormatter.string(from: dateFormat).uppercased()

        }
        return formatedDate
    }

    func format(destinationPattern: DateFormat, date: Date) -> String {
        var formatedDate: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.localeEn)
        dateFormatter.dateFormat = destinationPattern.rawValue
        formatedDate = format(dateString: dateFormatter.string(from: date),
                              sourcePattern: destinationPattern,
                              destinationPattern: destinationPattern)
        return formatedDate
    }

    func covertDateFormatToDate(destinationPattern: DateFormat, dateString: String) -> Date {
        let dateFormatter = getDateFormatterEnLocaleWithFullDateTimeTH()
        dateFormatter.dateFormat = destinationPattern.rawValue
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Bangkok")
        guard let dateFormat = dateFormatter.date(from: dateString) else {
            return Date()
        }
        return dateFormat
    }

    func formatWithLocal(destinationPattern: DateFormat, date: Date, destinationLanguageComponent: String) -> String {
        var formatedDate: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.localeEn)
        dateFormatter.dateFormat = destinationPattern.rawValue
        formatedDate = formatWithLocal(dateString: dateFormatter.string(from: date),
                                       sourcePattern: destinationPattern,
                                       sourceLanguageComponent: destinationLanguageComponent,
                                       destinationPattern: destinationPattern,
                                       destinationLanguageComponent: destinationLanguageComponent)
        return formatedDate
    }

    func getCurrentDate(destinationPattern: DateFormat) -> String {
        var formatedDate: String = ""
        let dateFormatter = getDateFormatterEnLocaleWithFullDateTimeTH()
        formatedDate = format(dateString: dateFormatter.string(from: Date()),
                              sourcePattern: DateFormat.fullDateTimeTH,
                              destinationPattern: destinationPattern)
        return formatedDate
    }

    func getDate(timestamp: TimeInterval, destinationPattern: DateFormat) -> String {
        let timestampInSecond = TimeInterval(exactly: timestamp / 1000)

        var date: Date
        if let aTimestampInSecond = timestampInSecond {
            date = Date(timeIntervalSince1970: aTimestampInSecond)
        } else {
            date = Date()
        }

        var formatedDate: String = ""
        let dateFormatter = getDateFormatterEnLocaleWithFullDateTimeTH()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Bangkok")
        formatedDate = format(dateString: dateFormatter.string(from: date),
                              sourcePattern: DateFormat.fullDateTimeTH,
                              destinationPattern: destinationPattern)
        return formatedDate
    }

    func getFullDateTimeTH(destinationPattern: DateFormat, date: Date) -> String {
        var formatedDate: String = ""
        let dateFormatter = getDateFormatterEnLocaleWithFullDateTimeTH()
        formatedDate = format(dateString: dateFormatter.string(from: date),
                              sourcePattern: DateFormat.fullDateTimeTH,
                              destinationPattern: destinationPattern)
        return formatedDate
    }

    func generateDayOfWeekAndTime(now: Date) -> String {
        let timeFormatter           = DateFormatter()
        timeFormatter.dateFormat    = DateFormat.cbsRequestIDComponent.rawValue
        let timeString              = timeFormatter.string(from: now)
        let myCalendar              = Calendar(identifier: .gregorian)
        let weekDay                 = myCalendar.component(.weekday, from: now)
        return String(weekDay) + timeString.dropLast()
    }
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = DateFormat.doctorAPI.rawValue
        dateFormater.timeZone = TimeZone(identifier: "Asia/Bangkok")
        let locale = Locale(identifier: Constants.localeTh)
        dateFormater.locale = locale
        if let birthdayDate = dateFormater.date(from: birthday) {
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
            let now = Date()
            let calcAge = calendar.components(.year, from: birthdayDate, to: now, options: [])
            let age = calcAge.year ?? 0
            return age
        } else {
            return 0
        }
    }
}

// MARK: - Private
extension DateFormatComponent {
    private func getDateFormatterEnLocaleWithFullDateTimeTH() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.localeEn)
        dateFormatter.dateFormat = DateFormat.fullDateTimeTH.rawValue
        return dateFormatter
    }
}

struct Constants {
    public static let apiKey = "TEST"
    public static let requestChannel = "PCHMERIOS"
    public static let localeEn = "en"
    public static let localeTh = "th"
}

struct LanguageComponent {
    static let thai = "th"
    static let english = "en"

    static func currentLanguage() -> String {
        return thai
    }
}
