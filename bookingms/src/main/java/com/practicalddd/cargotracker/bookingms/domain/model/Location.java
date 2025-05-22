package com.practicalddd.cargotracker.bookingms.domain.model;

/**
 * Location class represented by a unique 5-diigit UN Location code.
 */
public class Location implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    private String unLocCode;

    public Location() {
    }

    public Location(String unLocCode) {
        this.unLocCode = unLocCode;
    }

    public void setUnLocCode(String unLocCode) {
        this.unLocCode = unLocCode;
    }

    public String getUnLocCode() {
        return this.unLocCode;
    }
}
