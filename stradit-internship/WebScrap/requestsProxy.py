import requests

proxies = {
    "http": "http://23.175.248.21:1080",
    "https": "http://72.56.246.250:1080",
}

a = requests.get('https://api64.ipify.org?format=json', proxies=proxies )
print(a.json())