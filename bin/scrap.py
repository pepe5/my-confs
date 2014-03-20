import glob, os, subprocess, re, sys, time
domain = sys.argv [0]
extension = '?showChildren=true'
store = './sizes-store/'
links = './links/'
queue = './queue/'

from selenium import webdriver
fp = webdriver.FirefoxProfile ()
browser = webdriver.Firefox (firefox_profile=fp)
page = browser.get (domain); page
browser.get_cookies ()

aa = browser.find_elements_by_tag_name ('a'); aa
for a in aa: print a.get_attribute ('href')

# def init_level:
t = time.strftime ("%Y-%m-%d_%H:%M:%S", time.gmtime ()); t
subprocess.call ('echo %s >> %s/waiting/L00_%s.url' % (domain, queue, t), shell=True)

# def proc_one_level:
#(i) L = os.listdir ('%s/waiting/' % queue); L
LL = glob.glob ('%s/waiting/*.url' % queue)
LL.sort (key = lambda x: os.path.basename (x)); L
L = os.path.basename (L [0]) [1:3]

##
# 
login = '''wget..'''
rec = '''wget..'''
