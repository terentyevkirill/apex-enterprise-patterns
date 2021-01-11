trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {
    List<Task> tasks = new List<Task>();
    // Iterate through each event message.
    for (OpportunityChangeEvent event : Trigger.New) {
        // Get some event header fields
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;
        System.debug('Received change event for ' +
                     header.entityName +
                     ' for the ' + header.changeType + ' operation.');
        if (header.changetype == 'UPDATE' && event.isWon == true) {
			// Create a followup task
            Task tk = new Task();
            tk.Subject = 'Follow up on opportunities: ' + header.recordIds;
            tk.OwnerId = header.CommitUser;
            tasks.add(tk);
        }
    }
    // Insert all tasks in bulk.
    if (tasks.size() > 0) {
        insert tasks;
    }
}