const String kNotesTable = 'Notes';
const String kIdColumn = 'id';
const String kMoodColumn = 'mood';
const String kDateColumn = 'date';
const String kWakeupTimeColumn = 'wakeup_time';
const String kSleepTimeColumn = 'sleep_time';
const String kSleepLengthColumn = 'sleep_length';
const String kNoteTextColumn = 'note_text';

const String kCreateNotesTableQuery = "CREATE TABLE $kNotesTable ("
    "$kIdColumn INTEGER PRIMARY KEY,"
    "$kMoodColumn INTEGER,"
    "$kDateColumn TEXT,"
    "$kWakeupTimeColumn TEXT,"
    "$kSleepTimeColumn TEXT,"
    "$kSleepLengthColumn INTEGER,"
    "$kNoteTextColumn TEXT"
    ")";
