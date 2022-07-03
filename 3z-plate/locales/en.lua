local Translations = {
    error = {
        massage = 'Somtheng wrong happened!',
        ownermassage = 'you are not the vehicale owner!',
        plate = 'plate owned by anther player!',
    },
    enter = {
        massage = '[E] - Edit License Plate [ ~g~$%{value}~w~ ]'
    },
    Costs = {
        massage = 'Plate change fee',
        emassage = 'you dont have Plate change fee'
    },
    success = {
        massage = 'Plate number changed successfully'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- ex :
--Lang:t('error.canceled')