#!/bin/bash



function poll_coin {
    echo -e "coin: ${1}"

    OUTPUT=$(\
    curl "https://www.binance.com/bapi/earn/v1/friendly/pos/union?pageSize=15&pageIndex=1&status=ALL&asset=${1}" \
    -H 'authority: www.binance.com' \
    -H 'x-trace-id: 58129129-eda7-4186-a3c8-dd000ea5d4b0' \
    -H 'csrftoken: d41d8cd98f00b204e9800998ecf8427e' \
    -H 'x-ui-request-trace: 58129129-eda7-4186-a3c8-dd000ea5d4b0' \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36' \
    -H 'content-type: application/json' \
    -H 'lang: en' \
    -H 'fvideo-id: 31a094c75994ae3c97db9d362f25fa807d6dd439' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="96", "Google Chrome";v="96"' \
    -H 'device-info: eyJzY3JlZW5fcmVzb2x1dGlvbiI6IjI1NjAsMTQ0MCIsImF2YWlsYWJsZV9zY3JlZW5fcmVzb2x1dGlvbiI6IjI1NjAsMTQxNSIsInN5c3RlbV92ZXJzaW9uIjoiTWFjIE9TIDEwLjE1LjciLCJicmFuZF9tb2RlbCI6InVua25vd24iLCJzeXN0ZW1fbGFuZyI6ImVuLVVTIiwidGltZXpvbmUiOiJHTVQtNSIsInRpbWV6b25lT2Zmc2V0IjozMDAsInVzZXJfYWdlbnQiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV83KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTYuMC40NjY0LjExMCBTYWZhcmkvNTM3LjM2IiwibGlzdF9wbHVnaW4iOiJQREYgVmlld2VyLENocm9tZSBQREYgVmlld2VyLENocm9taXVtIFBERiBWaWV3ZXIsTWljcm9zb2Z0IEVkZ2UgUERGIFZpZXdlcixXZWJLaXQgYnVpbHQtaW4gUERGIiwiY2FudmFzX2NvZGUiOiJiNmE1ZjRmOCIsIndlYmdsX3ZlbmRvciI6IkFUSSBUZWNobm9sb2dpZXMgSW5jLiIsIndlYmdsX3JlbmRlcmVyIjoiQU1EIFJhZGVvbiBQcm8gNTMwME0gT3BlbkdMIEVuZ2luZSIsImF1ZGlvIjoiMTI0LjA0MzQ3NjU3ODA4MTAzIiwicGxhdGZvcm0iOiJNYWNJbnRlbCIsIndlYl90aW1lem9uZSI6IkFtZXJpY2EvTmV3X1lvcmsiLCJkZXZpY2VfbmFtZSI6IkNocm9tZSBWOTYuMC40NjY0LjExMCAoTWFjIE9TKSIsImZpbmdlcnByaW50IjoiZDc0ZDc2OGZmNWNjYjIxMWUwMTdmYjNmZjU1MDRlNzQiLCJkZXZpY2VfaWQiOiIiLCJyZWxhdGVkX2RldmljZV9pZHMiOiIifQ==' \
    -H 'bnc-uuid: a6f7dacf-613d-4f0d-b445-b8f0eb258137' \
    -H 'clienttype: web' \
    -H 'sec-ch-ua-platform: "macOS"' \
    -H 'accept: */*' \
    -H 'sec-fetch-site: same-origin' \
    -H 'sec-fetch-mode: cors' \
    -H 'sec-fetch-dest: empty' \
    -H 'referer: https://www.binance.com/en/pos' \
    -H 'accept-language: en-US,en;q=0.9' \
    -H 'cookie: cid=tbF829iD; bnc-uuid=a6f7dacf-613d-4f0d-b445-b8f0eb258137; source=referral; campaign=l.messenger.com; sajssdk_2015_cross_new_user=1; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%2217e5122da4352e-08f61f34338841-36657407-3686400-17e5122da44d07%22%2C%22first_id%22%3A%22%22%2C%22props%22%3A%7B%22%24latest_traffic_source_type%22%3A%22%E5%BC%95%E8%8D%90%E6%B5%81%E9%87%8F%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC%22%2C%22%24latest_referrer%22%3A%22https%3A%2F%2Fl.messenger.com%2F%22%7D%2C%22%24device_id%22%3A%2217e5122da4352e-08f61f34338841-36657407-3686400-17e5122da44d07%22%7D; _ga=GA1.2.1423134869.1642038746; _gid=GA1.2.678234340.1642038746; userPreferredCurrency=USD_USD; BNC_FV_KEY=31a094c75994ae3c97db9d362f25fa807d6dd439; BNC_FV_KEY_EXPIRE=1642125146299; fiat-prefer-currency=EUR' \
    --compressed \
    |jq '.data[].projects[].sellOut' )

    echo -e "sellOut values: \n${OUTPUT}\n"

    if [[ $OUTPUT =~ 'false' ]]
    then
        echo "Trigger email!"
        curl --ssl-reqd \
    --url 'smtps://smtp.gmail.com:465' \
    --user 'jay.juch@gmail.com:replace-with-your-gmail-api-key-here' \
    --mail-from 'jay.juch@gmail.com' \
    --mail-rcpt 'jay.juch@gmail.com' \
    --upload-file mail.txt
        exit
    fi

}

while true
do
    poll_coin cake
    sleep 3
done