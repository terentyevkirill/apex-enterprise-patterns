public class Accounts extends fflib_SObjectDomain {
    
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }

    public override void onApplyDefaults() {
        for (Account acc_i : (List<Account>) records) {
            if (acc_i.Description == null) {
                acc_i.Description = 'Domain classes rock!';
            }
        }
    }

    public override void handleBeforeInsert() {
        onApplyDefaults();
    }

    public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
        String str = 'Domain classes rock!';
        List<Account> updatedAccounts = new List<Account>();
        for (Account acc_i : (List<Account>) records) {
            acc_i.AnnualRevenue = str.getLevenshteinDistance(acc_i.Description);
            updatedAccounts.add(acc_i);
        }
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        uow.registerDirty(updatedAccounts);
    }
}