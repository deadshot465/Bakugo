import Foundation
import Sword
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

let presences = ["僕のヒーローアカデミア", "デク", "クソ髪", "クソナード", "丸顔", "クソメガネ", "半分野郎", "アホ面"]
let randomResponses = [
    "死ね！",
    "くだばれ！",
    "クソか！",
    "殺すぞ！",
    "遅んだよ！",
    "どこ見てんだよ！",
    "デクってのは何も出来ねー奴のことだな！",
    "俺は一番になってやる！",
    "黙ってついて来い！",
    "倒れねーってのは、クソ強ェだろ",
    "決めてンだよ俺ァ！勝負は必ず完全勝利！",
    "誰だよオメー",
    "ッんだこれ！",
    "勝つんだよ。それが…ヒーローなんだから",
    "てめェの何がオールマイトにそこまでさせたのか、確かめさせろ",
    "こっち来んな！"
]

let client = Sword(token: ProcessInfo.processInfo.environment["TOKEN"]!)

client.editStatus(to: "online", playing: presences.randomElement()!)

client.on(.ready) { data in
    DispatchQueue.global(qos: .background).async {
        while true {
            Thread.sleep(forTimeInterval: TimeInterval.init(3600))
            client.editStatus(to: "online", playing: presences.randomElement()!)
        }
    }
}

client.on(.messageCreate) { data in
    let msg = data as! Message
    let clientId = client.user!.id.rawValue

    if msg.content == "b?ping" {
        let currTime = Date.init()
        msg.reply(with: "🏓 ピング中") { (message: Message?, error: RequestError?) -> () in
            let endTime = Date.init()
            let diff = endTime.timeIntervalSince(currTime) * 1000.0
            let response = "🏓 ポン！\n\(diff.rounded())ミリ秒かかってんだ！クソか！"
            message!.edit(with: ["content": response])
        }
    }

    if msg.content == "b?about" {
        var embed = Embed()
        embed.author = Embed.Author(iconUrl: client.user!.imageUrl()!.absoluteString,
                name: "僕のヒーローアカデミアの爆豪勝己")
        embed.color = 0xE3DAC9
        embed.description = """
                            ザ・ランド・オブ・キュート・ボイズの爆豪勝己。
                            爆豪勝己はアニメ・マンガ・ゲーム「[僕のヒーローアカデミア](https://heroaca.com/)」の一人の主人公です。
                            爆豪バージョン0.1の開発者：
                            **Tetsuki Syu#1250、Kirito#9286**
                            制作言語・フレームワーク：
                            [Swift](https://swift.org/)と[Sword](https://github.com/Azoy/Sword)ライブラリ。
                            """
        embed.footer = Embed.Footer(text: "爆豪ボット：リリース 0.1 | 2021-03-29")
        embed.thumbnail = Embed.Thumbnail(height: 1000, proxyUrl: "", url: "https://cdn.discordapp.com/attachments/811517007446671391/825801928909783070/swift-logo-vector.png", width: 1000)
        msg.reply(with: embed)
    }

    if msg.content.contains(String(clientId)) {
        msg.reply(with: randomResponses.randomElement()!)
    }
}

client.connect()