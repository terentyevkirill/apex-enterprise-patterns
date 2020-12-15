trigger AccountsTrigger on Account (
    before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete
) {
    fflib_SObjectDomain.triggerHandler(Accounts.class);
}