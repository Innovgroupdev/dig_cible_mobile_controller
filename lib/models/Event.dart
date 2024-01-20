class Event {
  String id;
  String title;
  String userId;
  String country;
  String city;
  String location;
  String nbLike;
  String image;
  String accessCondition;
  List<Ticket> tickets;
  EventDetails details;
  List<EventDate> dates;
  String categoryId;
  String categoryName;
  String categoryCode;
  String typeBuffet;

  Event({
    required this.id,
    required this.title,
    required this.userId,
    required this.country,
    required this.city,
    required this.location,
    required this.nbLike,
    required this.image,
    required this.accessCondition,
    required this.tickets,
    required this.details,
    required this.dates,
    required this.categoryId,
    required this.categoryName,
    required this.categoryCode,
    required this.typeBuffet,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
      country: json['country'],
      city: json['city'],
      location: json['location'],
      nbLike: json['nbLike'],
      image: json['image'],
      accessCondition: json['access_condition'],
      tickets: (json['tickets'] as List<dynamic>)
          .map((ticket) => Ticket.fromJson(ticket))
          .toList(),
      details: EventDetails.fromJson(json['details']),
      dates: (json['dates'] as List<dynamic>)
          .map((date) => EventDate.fromJson(date))
          .toList(),
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryCode: json['category_code'],
      typeBuffet: json['type_buffet'],
    );
  }
}

class Ticket {
  String name;
  dynamic price;
  dynamic quantity;
  String advantage;

  Ticket({
    required this.name,
    required this.price,
    required this.quantity,
    required this.advantage,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      advantage: json['advantage'],
    );
  }
}

class EventDetails {
  String name;
  String entry;
  String mainMeal;
  String dessert;
  String beverage;

  EventDetails({
    required this.name,
    required this.entry,
    required this.mainMeal,
    required this.dessert,
    required this.beverage,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
      name: json['name'],
      entry: json['entry'],
      mainMeal: json['main_meal'],
      dessert: json['dessert'],
      beverage: json['beverage'],
    );
  }
}

class EventDate {
  String date;
  List<TimeSlot> timeSlots;

  EventDate({
    required this.date,
    required this.timeSlots,
  });

  factory EventDate.fromJson(Map<String, dynamic> json) {
    return EventDate(
      date: json['date'],
      timeSlots: (json['time_slots'] as List<dynamic>)
          .map((timeSlot) => TimeSlot.fromJson(timeSlot))
          .toList(),
    );
  }
}

class TimeSlot {
  String startTime;
  String endTime;

  TimeSlot({
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
