"""
Created on 6 апр. 2017 г.

@author: pavlo.ivanov


if __name__ == '__main__':
    pass
"""
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import ElementNotVisibleException
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import StaleElementReferenceException

from selenium.webdriver.common.keys import Keys
import time
import lxml.etree
from io import StringIO


def check_exists_by_xpath(webdriver, timeout, xpath):
    try:
        # webdriver.find_element_by_xpath(xpath)
        # WebDriverWait(webdriver, 5).until(EC.visibility_of_element_located((By.XPATH, xpath))) presence_of_element_located
        WebDriverWait(webdriver, timeout).until(EC.presence_of_element_located((By.XPATH, xpath)))
    except ElementNotVisibleException:
        print("Element NOT VISIBLE: " + str(xpath))
        return False
    except NoSuchElementException:
        print("No such element: " + str(xpath))
        return False
    except TimeoutException as ex:
        print("Element PRESENCE check TIMEOUT: " + str(ex))
        return False
    except:
        print("Unknown exception in EXISTENCE check: ")
        return False
    return True


# finally:
#    print("Unknown Exception wheen trying to fing the: " + str(xpath))
# print("Element NOT VISIBLE: " + str(xpath))
def check_visibility_by_xpath(webdriver, xpath):
    try:
        WebDriverWait(webdriver, 30).until(EC.visibility_of_element_located((By.XPATH, xpath)))
    except ElementNotVisibleException:
        print("Element NOT VISIBLE: " + str(xpath))
        return False
    except TimeoutException as ex:
        print("Element VISIBILITY check TIMEOUT: " + str(ex))
        return False
    except:
        print("Unknown exception in VISIBILITY check: ")
        return False
    return True


def admin_site_log_in(admin_browser, username, userpass):
    """
    
    :param admin_browser: 
    :param username: 
    :param userpass: 
    :return: 
    """
    user_id = admin_browser.find_element(By.ID, 'username-inputEl')
    password = admin_browser.find_element(By.ID, 'textfield-1026-inputEl')
    submit_button = admin_browser.find_element(By.ID, 'button-1030')

    user_id.send_keys(username)
    password.send_keys(userpass)
    submit_button.click()



def admin_site_log_out(admin_browser):
    """
    
    :param admin_browser: 
    :return: 
    """
    logout_link = WebDriverWait(admin_browser, timeout).until(EC.presence_of_element_located((By.XPATH, "//a[contains(text(),'Logout')]")))
    logout_link.click()




# =================================================================================

timeout = 30
default_timeout = 10
small_timeout = 2
counter = 1

agent_iframe_xpath = "//div[contains(@class,'lpview_widget right_pane_widget_wrapper_iframe') and contains(@style,'display: block')]//iframe[contains(@class,'lpview_table_items_placeholder table_items_placeholder lpview_iframe_tag iframeElement')]"
visitor_iframe_xpath = "//iframe[contains(@id,'LPFRM')]"

guest_link = None

admin_user_name = "pivanov"
admin_password = "4esZXdr5"

while counter == 1:
    print("Run " + str(counter) + " started")
    try:
        options = webdriver.ChromeOptions()
        # print(options)
        # options.addArguments("start-maximized")
        options.add_argument("--disable-notifications")
        options.add_argument("--disable-web-security")
        options.add_argument("--use-fake-ui-for-media-stream")
        options.add_argument("--mute-audio")

        options.add_experimental_option("prefs", {'download.prompt_for_download': False,
                                                  'directory_upgrade': True,
                                                  'download.default_directory': 'D:/'})

        # print(options.to_capabilities()) --disable-web-security
        # admin_browser = webdriver.Remote(command_executor='http://127.0.0.1:4444/wd/hub', desired_capabilities=DesiredCapabilities.CHROME)
        # admin_browser = webdriver.Remote(command_executor='http://127.0.0.1:4444/wd/hub', desired_capabilities=options.to_capabilities())
        admin_browser = webdriver.Chrome(chrome_options=options)

        admin_browser.implicitly_wait(small_timeout)
        admin_browser.set_script_timeout(small_timeout)

        admin_browser.get('https://free.vidyocloudstaging.com/admin/login.html')
        admin_browser.maximize_window()
        # admin_browser.implicitly_wait(30)
        # agent_site_login(admin_browser, 'Agent3', 'Agent123', '54424706')  # VEL-QA
        # agent_site_login(admin_browser, 'Agent2', 'Agent123', '54424706')  # VEL-QA
        # agent_site_login(admin_browser, 'Bohdan', 'Bohdan123', '57877913') # VEL

        WebDriverWait(admin_browser, timeout).until(EC.presence_of_element_located((By.XPATH, "//a[@id = 'button-1030']")))
        time.sleep(2)
        admin_site_log_in(admin_browser, admin_user_name, admin_password)
        time.sleep(2)

        admin_site_log_out(admin_browser)
        time.sleep(5)



    except StaleElementReferenceException as ex:
        print("StaleElementReferenceException exception: " + str(ex))
        pass
    except TimeoutException as ex:
        print("TimeOut exception in MAIN FLOW: " + str(ex))
        pass
    except:
        print("Unknown exception")
        pass
    finally:
        # time.sleep(10)
        admin_browser.quit()
        # print(admin_browser)
        #visitor_browser.quit()
        # print(visitor_browser)
        #try:
        #    guest_browser.quit()
        #except:
        #    print("Guest Browser has no instance and cannot be closed")
        # time.sleep(10)
        print("Run " + str(counter) + " finished")
        counter = counter + 1
