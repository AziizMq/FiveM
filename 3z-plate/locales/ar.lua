local Translations = {
    error = {
        massage = 'شي صار غلط!',
        ownermassage = 'منت مالك المركبة يالحبيب!',
        plate = 'اللوحة يملكها سائق اخر في المدينة!',
    },
    enter = {
        massage = '[E] - لتعديل لوحة السيارة [ ~g~$%{value}~w~ ]'
    },
    Costs = {
        massage = 'رسوم تغيير اللوحة',
        emassage = 'ما معك حق الرسوم لتغيير اللوحة'
    },
    success = {
        massage = 'تم تغيير اللوحة يا جيمس بوند'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- ex :
--Lang:t('error.canceled')