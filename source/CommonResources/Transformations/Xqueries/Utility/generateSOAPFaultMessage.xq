xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$soapbody" type="xs:anyType" ::)
(:: pragma  parameter="$osbfault" type="xs:anyType" ::)
(:: pragma  parameter="$osbinbound" type="xs:anyType" ::)
(:: pragma  parameter="$osboutbound" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "ikea.com/CommonResources/Xqueries/Utility/generateSOAPFaultMessage/";
declare namespace iipfaultmsg = "ikea.com/system/iip/IIPFaultMessage/1.0/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/"; 
declare namespace ctx = "http://www.bea.com/wli/sb/context"; 
declare namespace tp = "http://www.bea.com/wli/sb/transports"; 
declare namespace http = "http://www.bea.com/wli/sb/transports/http"; 


declare function xf:generateSOAPFaultMessage($soapbody as element(*),
    $osbfault as element(*),
    $osbinbound as element(*),
    $osboutbound as element(*))
    as element(*) {
        <soap-env:Fault>
        <faultcode xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/">soap-env:Server</faultcode>
        <faultstring>Server Error</faultstring>
        <detail>
        <iipfaultmsg:IIPFaultMessage>
        <iipfaultmsg:OperationName>{data($osbinbound/ctx:service/ctx:operation/text())}</iipfaultmsg:OperationName>
        <iipfaultmsg:ReportDateTime>{data(fn:current-dateTime())}</iipfaultmsg:ReportDateTime>
        {	 
			if ($soapbody/soap-env:Fault) then 
            <iipfaultmsg:ErrorContext>
                <iipfaultmsg:ErrorCode>{ $soapbody/soap-env:Fault/faultcode/text() }</iipfaultmsg:ErrorCode>
                <iipfaultmsg:ErrorText>{ $soapbody/soap-env:Fault/faultstring/text() }</iipfaultmsg:ErrorText>
                <iipfaultmsg:StackTrace>{ $soapbody/soap-env:Fault/detail/text() }</iipfaultmsg:StackTrace>    
            </iipfaultmsg:ErrorContext>
			else if (fn:substring-before(data($osbfault/ctx:errorCode),'-') ='BEA') then 
			<iipfaultmsg:ErrorContext>
                <iipfaultmsg:ErrorCode>{ data($osbfault/ctx:errorCode/text()) }</iipfaultmsg:ErrorCode>
                <iipfaultmsg:ErrorText>Error in operation: {$osbinbound/ctx:service/ctx:operation/text()}</iipfaultmsg:ErrorText>
                <iipfaultmsg:StackTrace>{$osbfault}</iipfaultmsg:StackTrace>    
			</iipfaultmsg:ErrorContext>
			else 
			" "
        }
        </iipfaultmsg:IIPFaultMessage>
        </detail>
        </soap-env:Fault>
};

declare variable $soapbody as element(*) external;
declare variable $osbfault as element(*) external;
declare variable $osbinbound as element(*) external;
declare variable $osboutbound as element(*) external;

xf:generateSOAPFaultMessage($soapbody,
    $osbfault,
    $osbinbound,
    $osboutbound)