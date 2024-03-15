// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

List<Services> servicesFromJson(String str) => List<Services>.from(json.decode(str).map((x) => Services.fromJson(x)));

class Services {
    Service? service;

    Services({
        this.service,
    });

    factory Services.fromJson(Map<String, dynamic> json) => Services(
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
    );

}

class Service {
    int? id;
    String? title;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? interval;
    bool? hasDayBooking;
    int? bookingCapacity;
    dynamic dayBookingSpecifyTime;
    int? maxSlots;
    bool? sameDay;
    dynamic price;
    bool? active;
    bool? paymentRequired;
    dynamic intervalRounding;
    dynamic template;
    String? bookingType;
    dynamic description;
    dynamic customData;
    dynamic mailConfirmation;
    dynamic mailVerification;
    dynamic smsConfirmation;
    dynamic smsVerification;
    dynamic smsReminder;
    dynamic bookingForm;
    dynamic nextInterval;
    bool? allowInvoice;
    int? bookingTypeId;
  

    Service({
        this.id,
        this.title,
        this.createdAt,
        this.updatedAt,
        this.interval,
        this.hasDayBooking,
        this.bookingCapacity,
        this.dayBookingSpecifyTime,
        this.maxSlots,
        this.sameDay,
        this.price,
        this.active,
        this.paymentRequired,
        this.intervalRounding,
        this.template,
        this.bookingType,
        this.description,
        this.customData,
        this.mailConfirmation,
        this.mailVerification,
        this.smsConfirmation,
        this.smsVerification,
        this.smsReminder,
        this.bookingForm,
        this.nextInterval,
        this.allowInvoice,
        this.bookingTypeId,
   
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        title: json["title"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        interval: json["interval"],
        hasDayBooking: json["has_day_booking"],
        bookingCapacity: json["booking_capacity"],
        dayBookingSpecifyTime: json["day_booking_specify_time"],
        maxSlots: json["max_slots"],
        sameDay: json["same_day"],
        price: json["price"],
        active: json["active"],
        paymentRequired: json["payment_required"],
        intervalRounding: json["interval_rounding"],
        template: json["template"],
        bookingType: json["booking_type"],
        description: json["description"],
        customData: json["custom_data"],
        mailConfirmation: json["mail_confirmation"],
        mailVerification: json["mail_verification"],
        smsConfirmation: json["sms_confirmation"],
        smsVerification: json["sms_verification"],
        smsReminder: json["sms_reminder"],
        bookingForm: json["booking_form"],
        nextInterval: json["next_interval"],
        allowInvoice: json["allow_invoice"],
        bookingTypeId: json["booking_type_id"],
       
    );
}



