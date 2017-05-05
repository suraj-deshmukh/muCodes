import re

text = 'aUe!0V2B!080!aTfu9ST14al Kaleigh Z. HAMMETT ONOGI@ATT.NET +001 004 513173 M aTfv@ST36a AWC!aTfu9ST14a AWCIO08A \"2663 PAM ST1212 19TH STREET S Charleston 40277 MA\" \"PO BOX 216214362 30TH AVE NE Oceanside 98079\" 20000000 0802AW0 1 Y 0'

splited_words = text.split() 
tbc_security = splited_words[0]
email_id = re.search(r'[\w\.-]+@[\w\.-]+',text).group()
name = splited_words[1:splited_words.index(email_id)]

splited_words.remove(tbc_security)
# splited_words.remove(name)
splited_words.remove(email_id)
_ = [splited_words.remove(i) for i in name]
name = ' '.join(name)
contact_number = re.search(r'\+[0-9-\s]+[0-9]',text).group()
_ = [splited_words.remove(i) for i in contact_number.split()]
gender = splited_words[0]
licence_no = splited_words[1]
gir_no = splited_words[2]
pan_no = splited_words[3]
splited_words.remove(gender)
splited_words.remove(licence_no)
splited_words.remove(gir_no)
splited_words.remove(pan_no)
tmp = ' '.join(splited_words)

adres = re.findall(r'\"(.+?)\"',tmp)
home = adres[0]
split_home = home.split()
city = split_home[-3]
pin = split_home[-2]
state = split_home[-1]
split_home.remove(city)
split_home.remove(pin)
split_home.remove(state)
home = ' '.join(split_home)
office = adres[1]
office_split = office.split()
office_city = office_split[-2]
office_pin = office_split[-1]
office_split.remove(office_city)
office_split.remove(office_pin)
office = ' '.join(office_split)
cp = splited_words[-1]
nri = splited_words[-2]
af = splited_words[-3]
mrn_no = splited_words[-4]
loan_aprov_limit = splited_words[-5]
