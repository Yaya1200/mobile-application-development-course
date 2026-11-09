import '../domain/event.dart';

/// In-memory sample data until week 9 replaces it with the REST backend.
final sampleEvents = <Event>[
  Event(
    id: 'e1',
    title: 'Flutter study group',
    start: DateTime(2026, 10, 14, 16),
    venue: Venue.technology,
    description: 'Weekly session: this week, layouts and constraints.',
  ),
  Event(
    id: 'e2',
    title: 'Career fair: software and telecom',
    start: DateTime(2026, 10, 16, 9),
    venue: Venue.mainCampus,
    description: 'Ethio Telecom, Safaricom, Kifiya, Gebeya and others.',
  ),
  Event(
    id: 'e3',
    title: 'Hackathon kickoff',
    start: DateTime(2026, 10, 18, 8, 30),
    venue: Venue.scienceFaculty,
    description: '48 hours. Teams of four. Theme announced on the day.',
    isFree: false,
  ),
  Event(
    id: 'e4',
    title: 'Guest lecture: mobile money at scale',
    start: DateTime(2026, 10, 21, 14),
    venue: Venue.online,
    description: 'How Telebirr handles millions of transactions a day.',
  ),
  Event(
    id: 'e5',
    title: 'Library orientation',
    start: DateTime(2026, 10, 22, 10),
    venue: Venue.mainCampus,
  ),
  Event(
    id: 'e6',
    title: 'Football: CS vs EE',
    start: DateTime(2026, 10, 24, 17),
    venue: Venue.technology,
    description: 'Bring your department colours.',
  ),
];
