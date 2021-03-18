public with sharing class LoginEventMonitoringHandler {
    public static List<LoginEvent> getLoginEvents() {
        return Database.query('SELECT SourceIP, Country, City, Username FROM LoginEvent where EventDate = Today');
    }
}