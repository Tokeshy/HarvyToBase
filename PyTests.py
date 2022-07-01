from requests import get


url_1 = 'http://www.icetrade.by/tenders/all/view/110'
url_2 = 'http://www.icetrade.by/tenders/all/view/1000000'

print(get(url_1, verify=False).text)
 #print((get(url_2, verify=False).status_code))
 #print((get(url_2, verify=False).status_code))
print(len(get(url_1, verify=False).text))
#print(get(url_2).text)