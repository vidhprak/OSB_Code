xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:IIPResponseMessage" location="../../../../CommonResources/DataModels/Infrastructure/ErrorHandling/V1/IIPResponseMessage.xsd" ::)

declare namespace xf = "ikea.com/XQueries/OrderIDOMProvider/XfGenerateOrderResponseMessage/";
declare namespace ns0 = "ikea.com/system/iip/IIPResponseMessage/1.0/";

declare function xf:XfGenerateOrderResponseMessage()
as element(ns0:IIPResponseMessage) {
    <ns0:IIPResponseMessage>
     <ns0:Status>SUCCESS</ns0:Status>
     </ns0:IIPResponseMessage>
};


xf:XfGenerateOrderResponseMessage()