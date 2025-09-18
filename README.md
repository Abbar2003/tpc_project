# TPC Factory Management System

A comprehensive system for managing factory operations—production, inventory, sales, and finance—designed to automate and track every stage from raw materials to the final product, with automatic pricing and accurate financial reporting.

# 📝 Project Overview

The platform provides unified management for:

Raw materials & batches with consumption tracking and low-stock alerts.

Products & Bill of Materials (BOM) with automatic cost and selling-price calculation.

Production & conversions with real cost tracking.

Sales & damages with instant inventory and profit/loss updates.

Expenses & financial reports (daily, monthly, yearly).

Notifications & activity logs for complete transparency.

# ✨ Key Features

Role-based user management (Admin, Accountant, Storekeeper, Sales).

Real-time reports and analytics for better decision-making.

Responsive UI for Web, Android, iOS, and Desktop.

Advanced security with Laravel Sanctum authentication, data encryption, and fine-grained permissions.

Scalable architecture ready for future modules (supplier portal, external integrations).

# 🏗️ Tech Stack

Frontend: Flutter (Android) with Bloc/Cubit state management.

Backend: Laravel (PHP) using MVC and dedicated service layers.

Database: MySQL with ACID transactions and optimized indexing.

API: RESTful endpoints secured via Sanctum tokens and role policies.

# 📂 Core Database Tables

users, roles

raw_materials, raw_batches

products, boms, product_batches, conversions

sales, damages

expenses, production_settings

notifications, activity_logs

# 🚀 Local Development Setup
Prerequisites

PHP 8+ and Composer

MySQL 8+

Node.js & Flutter SDK

Steps
# Backend
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve

# Frontend
cd frontend
flutter pub get
flutter run

# 👥 User Roles

Admin: Full access and configuration control.

Accountant: Handles sales, expenses, and financial reports.

Storekeeper: Manages raw materials, batches, and damages.

Production Manager / Sales: Access based on assigned role.

# 📊 Reporting

Production & sales summaries (daily / monthly / yearly).

Real-time profit & loss reports.

Stock shortage and threshold alerts.

# 📚 Technical References

Laravel Documentation

Flutter Documentation

MySQL Documentation

