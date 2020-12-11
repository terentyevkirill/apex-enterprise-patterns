global class CaseService {

    global static void closeCases(Set<Id> caseIds, String reason) {
        if (caseIds == null || caseIds.size() == 0) {
            throw new CaseServiceException('Cases not specified');
        }
        if (reason == null || String.isBlank(reason)) {
            throw new CaseServiceException('Close reason not specified');
        }
        List<Case> cases = [
            SELECT Id
            FROM Case
            WHERE Id IN :caseIds
        ];
        for (Case case_i : cases) {
            case_i.Reason = reason;
            case_i.Status = 'Closed';
        }
        SavePoint sp = Database.setSavePoint();
        try {
            update cases;
        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        }
    }

    global class CaseServiceException extends Exception { }
     
}