//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-22.
//

import Foundation

/**
 URL: https://api.coingecko.com/api/v3/global
 
 {
   "data": {
     "active_cryptocurrencies": 11210,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 686,
     "total_market_cap": {
       "btc": 43259553.01425941,
       "eth": 681979224.282067,
       "ltc": 14689860418.015844,
       "bch": 9332261911.844044,
       "bnb": 3700206624.606676,
       "eos": 1073385288212.0338,
       "xrp": 2802255017654.042,
       "xlm": 13185853839970.443,
       "link": 164432460305.18176,
       "dot": 195056027308.91898,
       "yfi": 139643186.04865012,
       "usd": 1202497632395.1206,
       "aed": 4416166542482.938,
       "ars": 246987632517052.9,
       "aud": 1791307813083.1855,
       "bdt": 126401659357006.5,
       "bhd": 453616979370.7798,
       "bmd": 1202497632395.1206,
       "brl": 6274873145364.23,
       "cad": 1646072554037.7673,
       "chf": 1102820198650.625,
       "clp": 975478104375245.9,
       "cny": 8274025459221.122,
       "czk": 26208402228117.94,
       "dkk": 8230256950397.196,
       "eur": 1105300951266.2534,
       "gbp": 977976894455.3644,
       "hkd": 9436893579643.018,
       "huf": 427281924079529.1,
       "idr": 18208329761471620,
       "ils": 4357214096054.746,
       "inr": 99119112891277.42,
       "jpy": 158015191677755.8,
       "krw": 1551626996294698,
       "kwd": 368300974849.9775,
       "lkr": 387827773538545.1,
       "mmk": 2525300995877057.5,
       "mxn": 22196223182721.582,
       "myr": 5363139440482.228,
       "ngn": 553690034836334.1,
       "nok": 12527104462808.047,
       "nzd": 1924653978037.1108,
       "php": 65226475420197.01,
       "pkr": 340330497526219.75,
       "pln": 5178605356312.505,
       "rub": 92544202156659.08,
       "sar": 4516824011797.818,
       "sek": 12364239385974.107,
       "sgd": 1597320895025.2058,
       "thb": 41129026520810.3,
       "try": 22891466428852.97,
       "twd": 36471753190543.984,
       "uah": 44412758955449.53,
       "vef": 120406087931.72346,
       "vnd": 28287420167054420,
       "zar": 21946700114009.066,
       "xdr": 901051918413.4125,
       "xag": 52504509823.55233,
       "xau": 612347869.3445671,
       "bits": 43259553014259.414,
       "sats": 4325955301425941.5
     },
     "total_volume": {
       "btc": 2784768.801613325,
       "eth": 43901389.05279831,
       "ltc": 945637717.9547083,
       "bch": 600750354.771841,
       "bnb": 238195248.21098116,
       "eos": 69097566998.39935,
       "xrp": 180390961153.83124,
       "xlm": 848819551697.1542,
       "link": 10585092852.88857,
       "dot": 12556439019.087109,
       "yfi": 8989320.526219573,
       "usd": 77408980384.14807,
       "aed": 284284093415.8831,
       "ars": 15899458165716.8,
       "aud": 115312752083.12846,
       "bdt": 8136917118249.443,
       "bhd": 29200912261.33185,
       "bmd": 77408980384.14807,
       "brl": 403935541440.5622,
       "cad": 105963450250.2918,
       "chf": 70992395182.14532,
       "clp": 62794938977424.766,
       "cny": 532627971329.2087,
       "czk": 1687126560021.0562,
       "dkk": 529810439261.1859,
       "eur": 71152089908.67764,
       "gbp": 62955794838.66312,
       "hkd": 607485861355.8159,
       "huf": 27505632600451.78,
       "idr": 1172133901441830,
       "ils": 280489118152.5489,
       "inr": 6380644135001.446,
       "jpy": 10171990815996.578,
       "krw": 99883659213912.52,
       "kwd": 23708822512.056866,
       "lkr": 24965830871930.184,
       "mmk": 162562461652884.94,
       "mxn": 1428848555428.0908,
       "myr": 345244052513.2997,
       "ngn": 35642965017881.03,
       "nok": 806413549189.4684,
       "nzd": 123896711326.90689,
       "php": 4198856463669.187,
       "pkr": 21908265012265.812,
       "pln": 333364947792.52875,
       "rub": 5957394124047.278,
       "sar": 290763766936.8978,
       "sek": 795929354295.2212,
       "sgd": 102825135367.55775,
       "thb": 2647619356079.0156,
       "try": 1473603795980.874,
       "twd": 2347814375051.209,
       "uah": 2859004703352.8276,
       "vef": 7750961205.864748,
       "vnd": 1820960219662346.2,
       "zar": 1412785882362.4587,
       "xdr": 58003864954.508545,
       "xag": 3379899021.4354157,
       "xau": 39418975.08101971,
       "bits": 2784768801613.3247,
       "sats": 278476880161332.47
     },
     "market_cap_percentage": {
       "btc": 44.67229930376301,
       "eth": 17.66984995132788,
       "usdt": 6.476424138992304,
       "bnb": 4.267637248376914,
       "usdc": 2.925965727727157,
       "xrp": 1.8182323807327423,
       "ada": 1.067597021167344,
       "steth": 0.858117474502512,
       "doge": 0.8572553252576816,
       "matic": 0.8471373699824268
     },
     "market_cap_change_percentage_24h_usd": -1.6650313372095789,
     "updated_at": 1679513022
   }
 }
 
 
 */

// MARK: - GlobalDate
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
