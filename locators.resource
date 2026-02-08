*** Variables ***
# --- Language & Auth (Base) ---
${LANG_ENG_ANDROID}    xpath=//*[contains(@text, "English")]
${LANG_ENG_IOS}        accessibility_id=English
${GET_STARTED_ANDROID}  xpath=//*[contains(@text, "GET STARTED")]
${GET_STARTED_IOS}      accessibility_id=GET STARTED

# --- Navigation Bar ---
# Android using ID from Java, iOS using the TabBar
${ACC_BTN_ANDROID}     id=com.setel.mobile.staging2:id/button_account
${ACC_BTN_IOS}         xpath=//XCUIElementTypeTabBar/XCUIElementTypeButton[5]

# --- One-Tap Fuelling Settings ---
${OTF_SWITCH_ANDROID}  id=com.setel.mobile.staging2:id/switcher
${OTF_SWITCH_IOS}      accessibility_id=OneTapFuelSetupViewController_featureSwitch

${OTF_SAVE_BTN_ANDROID}  id=com.setel.mobile.staging2:id/button_save
${OTF_SAVE_BTN_IOS}      accessibility_id=OneTapFuelSetupViewController_ctaButton

${OTF_AMOUNT_TAB_ANDROID}  id=com.setel.mobile.staging2:id/button_amount
${OTF_AMOUNT_TAB_IOS}      accessibility_id=OneTapFuelPresetsViewController_amountItemView

${OTF_LITRES_TAB_ANDROID}  id=com.setel.mobile.staging2:id/button_litres
${OTF_LITRES_TAB_IOS}      accessibility_id=OneTapFuelPresetsViewController_litresItemView

${OTF_FULL_TANK_BTN_ANDROID}  id=com.setel.mobile.staging2:id/button_full_tank
${OTF_FULL_TANK_BTN_IOS}      accessibility_id=OneTapFuelPresetsViewController_fullTankItemView

# --- Payment Methods ---
${WALLET_PAY_ANDROID}  id=com.setel.mobile.staging2:id/text_setel_wallet_amount
${WALLET_PAY_IOS}      accessibility_id=PaymentMethodTableViewCell_0_0_balanceLabel

${FAMILY_WALLET_ANDROID}  xpath=//android.widget.TextView[@text="Family Wallet"]
${FAMILY_WALLET_IOS}      accessibility_id=Family Wallet

${SMARTPAY_ANDROID}       xpath=//*[@text='SmartPay']
${SMARTPAY_IOS}           accessibility_id=PaymentMethodTableViewCell_1_0_balanceLabel

# --- Common UI Components ---
${BACK_BTN_ANDROID}    className=android.widget.ImageButton
${BACK_BTN_IOS}        accessibility_id=ic back arrow

${CLOSE_BTN_ANDROID}   id=com.setel.mobile.staging2:id/button_close
${CLOSE_BTN_IOS}       accessibility_id=ic back cross

${OK_GOT_IT_BTN_ANDROID}  id=com.setel.mobile.staging2:id/button_ok
${OK_GOT_IT_BTN_IOS}      accessibility_id=PreAuthorisationHoldViewController_gotItButton