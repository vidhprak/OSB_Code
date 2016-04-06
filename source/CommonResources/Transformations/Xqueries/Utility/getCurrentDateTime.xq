xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/BookingService/Resources/XQueries/test/";

declare function xf:currentDateTime($uin as xs:int) as xs:string{
    (: "yyyy-MM-ddThh:mm:ss" 2008-09-29T03:49:45 :)
    let $dateTime := concat(xf:currentDate(), "T", xf:currentTime())   
    return $dateTime
};

declare function xf:currentDate() as xs:string{
    (: "yyyy-MM-dd" 2008-09-29 :)
    let $month := if (month-from-dateTime(current-dateTime()) < 10) then concat("0", month-from-dateTime(current-dateTime())) else month-from-dateTime(current-dateTime())   
    let $day := if (day-from-dateTime(current-dateTime()) < 10) then concat("0", day-from-dateTime(current-dateTime())) else day-from-dateTime(current-dateTime())   
    let $date := concat(year-from-dateTime(current-dateTime()), "-", $month, "-", $day)   
    return $date
};

declare function xf:currentTime() as xs:string{
    (: "hh:mm:ss" 03:49:45 :)
    let $hour := if (hours-from-dateTime(current-dateTime()) < 10) then concat("0", hours-from-dateTime(current-dateTime())) else hours-from-dateTime(current-dateTime())   
    let $minute := if (minutes-from-dateTime(current-dateTime()) < 10) then concat("0", minutes-from-dateTime(current-dateTime())) else minutes-from-dateTime(current-dateTime())   
    let $second := if (seconds-from-dateTime(current-dateTime()) < 10) then concat("0", seconds-from-dateTime(current-dateTime())) else seconds-from-dateTime(current-dateTime())   
    let $time := concat($hour, ":", $minute, ":", $second)    
    return $time
};

declare variable $uin as xs:int external;

xf:currentDateTime($uin)