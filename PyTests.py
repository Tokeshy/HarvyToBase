#import requests


#url_1 = 'http://www.icetrade.by/tenders/all/view/110'
#url_2 = 'http://www.icetrade.by/tenders/all/view/1000000'







#print(get(url_1, verify=False).text)
 #print((get(url_2, verify=False).status_code))
 #print((get(url_2, verify=False).status_code))
#print(len(get(url_1, verify=False).text))
#print(get(url_2).text)

#url = "https://www.onliner.by/:80"
#proxy_host = '186.10.252.90'
#proxy_port = "999"
#User = ''
#password = ''
#proxy_auth = ':'
#proxies = {
#       "https": "https://{}@{}:{}/".format(proxy_auth, proxy_host, proxy_port),
#       "http": "http://{}@{}:{}/".format(proxy_auth, proxy_host, proxy_port)
#}
#print(requests.get(url, proxies=proxies, verify=False).text)

#url = "https://www.onliner.by/"

#proxies = {'https': '194.186.81.186:8181'}

#r = requests.get(url, proxies=proxies)

#print(r.text)

#a = 'a##b##c##d'
#print(a.split('##'))


from requests import get

url = 'https://icetrade.by/tenders/all/view/111'

print(get(url, verify = False).text)

