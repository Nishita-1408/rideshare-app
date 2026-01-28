-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.bookings (
  booking_id uuid NOT NULL DEFAULT uuid_generate_v4(),
  ride_id uuid,
  user_id uuid,
  status USER-DEFINED DEFAULT 'CONFIRMED'::booking_status,
  booked_at timestamp with time zone DEFAULT now(),
  CONSTRAINT bookings_pkey PRIMARY KEY (booking_id),
  CONSTRAINT bookings_ride_id_fkey FOREIGN KEY (ride_id) REFERENCES public.rides(ride_id),
  CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);
CREATE TABLE public.drivers (
  driver_id uuid NOT NULL DEFAULT uuid_generate_v4(),
  full_name text NOT NULL,
  contact_number character varying NOT NULL,
  review_score numeric DEFAULT 5.00 CHECK (review_score <= 5.0),
  CONSTRAINT drivers_pkey PRIMARY KEY (driver_id)
);
CREATE TABLE public.rides (
  ride_id uuid NOT NULL DEFAULT uuid_generate_v4(),
  driver_id uuid,
  source_name text NOT NULL,
  dest_name text NOT NULL,
  departure_time timestamp with time zone NOT NULL,
  status USER-DEFINED DEFAULT 'OPEN'::ride_status,
  total_seats integer NOT NULL CHECK (total_seats > 0),
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT rides_pkey PRIMARY KEY (ride_id),
  CONSTRAINT rides_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.drivers(driver_id)
);
CREATE TABLE public.users (
  user_id uuid NOT NULL DEFAULT uuid_generate_v4(),
  firebase_uid character varying NOT NULL UNIQUE,
  full_name text NOT NULL,
  email text NOT NULL UNIQUE,
  roll_no text NOT NULL,
  gender USER-DEFINED,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT users_pkey PRIMARY KEY (user_id)
);
