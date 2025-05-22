package com.practicalddd.cargotracker.bookingms.domain.model;

/**
 * Booking Amount of the Cargo
 */

public class BookingAmount implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    private int bookingAmount;

    public BookingAmount() {}

    public BookingAmount(int bookingAmount) {
        this.bookingAmount = bookingAmount;
    }

}
