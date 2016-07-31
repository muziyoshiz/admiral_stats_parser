# admiral_stats_parser

Parser for admiral stats JSON data exported from kancolle-arcade.net

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'admiral_stats_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admiral_stats_parser

## Usage

```
# 基本情報
AdmiralStatsParser.parse_personal_basic_info(json, api_version)

# 海域情報
AdmiralStatsParser.parse_area_capture_info(json, api_version)

# 艦娘図鑑
AdmiralStatsParser.parse_tc_book_info(json, api_version)

# 装備図鑑
AdmiralStatsParser.parse_equip_book_info(json, api_version)

# 艦娘一覧
AdmiralStatsParser.parse_character_list_info(json, api_version)

# 装備一覧
AdmiralStatsParser.parse_equip_list_info(json, api_version)
```

## Specification

提督情報ページから返される JSON メッセージの形式は、過去に一度変更されており、今後も変更される可能性があります。このツールでは、kancolle-arcade.net が返す JSON メッセージの形式のことを API version と呼びます。

AdmiralStatsParser は、以下の API version をサポートしています。

| API version | 期間 |
|------------:|:-----|
| 1           | 2016-04-26 〜 2016-06-29 |
| 2           | 2016-06-30（REVISION 2 のリリース日）〜 |

各 API version でパースできる JSON の種類は以下の通りです。また、同じ情報でも、API version によって、含まれる情報量が異なる場合があります。その場合は Supported (1), Supported (2) のように記載して区別しています。

| 提督情報での表示 | URL | API version 1 | API version 2 |
|:----------------|:----|:--------------|:--------------|
| 基本情報 | Personal/basicInfo | Supported (1) | Supported (2) |
| 海域情報 | Area/captureInfo   | Supported (1) | Supported (2) |
| 艦娘図鑑 | TcBook/info        | Supported (1) | Supported (2) |
| 装備図鑑 | EquipBook/info     | Supported     | Supported     |
| 艦娘一覧 | CharacterList/info | -             | Supported     |
| 装備一覧 | EquipList/info     | -             | Supported     |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/admiral_stats_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

