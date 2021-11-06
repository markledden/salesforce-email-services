global class EmailServiceHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

            // Create a new record in the audit object
            Email_Service_Message__c messageRecord = new Email_Service_Message__c(
                Subject__c    = email.subject,
                Sender__c     = email.fromAddress,
                Recipients__c = string.join(email.toAddresses,','),
                Body__c       = email.htmlBody);
            insert messageRecord;

            Boolean hasCSV = false;
            
            // If there are attachments on the email, save them as attachments on the audit record
            if (email.binaryAttachments != null) {
                for (Messaging.InboundEmail.BinaryAttachment bAttachment : email.binaryAttachments) {
                    Attachment attachment   = new Attachment(
                        Name = bAttachment.fileName,
                        Body = bAttachment.body,
                        ParentId = messageRecord.Id);
                    insert attachment;

                    if (attachment.Name.endsWith('.csv')) {
                        hasCSV = true;
                    }
                }
            }

            messageRecord.Has_CSV__c = hasCSV;
            update messageRecord;
            
    return result;
    }
}