xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "ikea.com/CommonResources/Xqueries/Utility/XfICMServiceAccountToICMHeader/";
declare namespace soap="http://schemas.xmlsoap.org/soap/envelope/";
declare namespace sieb = "http://siebel.com/webservices";

declare function xf:XfICMServiceAccountToICMHeader($username as xs:string,
    $password as xs:string)
    as element(*) {
    <soap:Header>
	<sieb:UsernameToken>{$username}</sieb:UsernameToken>
	<sieb:PasswordText>{$password}</sieb:PasswordText>
	<sieb:SessionType>None</sieb:SessionType>
	</soap:Header>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:XfICMServiceAccountToICMHeader($username,
    $password)