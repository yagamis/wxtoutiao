function elementPosition(obj) {
    var curleft = 0, curtop = 0;
    if (obj.offsetParent) {
        curleft = obj.offsetLeft;
        curtop = obj.offsetTop;
        while (obj = obj.offsetParent) {
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
        }
    }
    return { x: curleft, y: curtop };
}
function ScrollToControl(id)
{
    var elem = document.getElementById(id);
    var scrollPos = elementPosition(elem).y;
    scrollPos = scrollPos - document.documentElement.scrollTop;
    var remainder = scrollPos % 50;
    var repeatTimes = (scrollPos - remainder) / 50;
    ScrollSmoothly(scrollPos,repeatTimes);
    window.scrollBy(0,remainder);
}
var repeatCount = 0;
var cTimeout;
var timeoutIntervals = new Array();
var timeoutIntervalSpeed;
function ScrollSmoothly(scrollPos,repeatTimes)
{
    if(repeatCount < repeatTimes)
    {
        window.scrollBy(0,50);
    }
    else
    {
        repeatCount = 0;
        clearTimeout(cTimeout);
        return;
    }
    repeatCount++;
    cTimeout = setTimeout("ScrollSmoothly('"+scrollPos+"','"+repeatTimes+"')",100);
}
