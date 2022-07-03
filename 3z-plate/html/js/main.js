let harfdata = [{ 1: "1", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "0", 11: "A", 12: "B", 13: "C", 14: "D", 15: "E", 16: "F", 17: "G", 18: "H", 19: "I", 20: "J", 21: "K", 22: "L", 23: "M", 24: "N", 25: "O", 26: "P", 27: "Q", 28: "R", 29: "S", 30: "T", 31: "U", 32: "V", 33: "W", 34: "X", 35: "Y", 36: "Z", 37: " " }]

window.addEventListener('message', function(event) {
    var item = event.data;
 
    if (item.type === "ui") {
        $('body').css("display", "block");
    } else if (item.type = 'close') {
        $('body').css("display", "none");
    }
});

$(".arttir").click(function() {
    var values = Object.values(harfdata[0]);
    var elementDatasi = $(this).parent().find('.text1').text();
    if (elementDatasi == values[values.length - 1]) return console.log('you reached the maximum');
    for (let i = 0; i < values.length; i++) {
        if (values[i] == elementDatasi) {
            elementDatasi = values[i + 1];
            var id = '#' + $(this).parent().data('id');
            $(id).text(elementDatasi);
            return;
        }
    }
});

$(".azalt").click(function() {
    var values = Object.values(harfdata[0]);
    var elementDatasi = $(this).parent().find('.text1').text();
    for (let i = 0; i < values.length; i++) {
        if (values[i] == elementDatasi && values[i - 1] != undefined) {
            elementDatasi = values[i - 1];
            var id = '#' + $(this).parent().data('id');
            $(id).text(elementDatasi);
            return;
        }
    }
});

$(".kaydetyazi").click(function() { 
   $('body').css("display", "none");
   $.post('https://3z-plate/NUICB', JSON.stringify({ plate: getPlate() }));
});

$(".fa-save").click(function() { 
   $('body').css("display", "none");
   $.post('https://3z-plate/NUICB', JSON.stringify({ plate: getPlate() }));
});


$(".iptal").click(function() { 
   $('body').css("display", "none");
   $.post("https://3z-plate/NUICB");
});

$(".iptalyazi").click(function() { 
   $('body').css("display", "none");
   $.post("https://3z-plate/NUICB");
});

function getPlate() {
    var plate = "";
    var objects = $(".box");
    plate += $(objects).find('.text1').text();
    console.log(plate);
    return plate;

}