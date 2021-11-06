@isTest
private class EmailServiceHandlerTest {

    static testMethod void testHandler() {
  
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope   = new Messaging.InboundEnvelope();
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      
        List<String> recipients = new List<String>();
        recipients.add('recipient-a@example.com.uk');
        recipients.add('recipient-b@example.com.uk');
    
        email.subject = 'Test Email Subject';
        email.fromAddress = 'sender@example.com.uk';
        email.toAddresses = recipients;
        email.htmlBody = 'Example Email Body - This is for Testing Purposes';

        String csvString = 'Name,Company\nJohn,ABC Co';
        attachment.body = blob.valueOf(csvString);
        attachment.fileName = 'attachmentFileName.csv';
        attachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

        EmailServiceHandler esm = new EmailServiceHandler();
        esm.handleInboundEmail(email, envelope);

        Test.startTest();

        Messaging.InboundEmailResult result = esm.handleInboundEmail(email, envelope);

        Test.stopTest();
        
        
        

                            
    }
     
}