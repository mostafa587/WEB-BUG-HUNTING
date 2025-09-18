# 🚨 WordPress Plugin Vulnerability Report

## 📌 Plugin Overview

- **Plugin Name:** Header Footer Elementor
- **Slug:** `header-footer-elementor`
- **Affected Versions:** <= 1.6.42
- **Fixed Version:** 1.6.43
- **Plugin URI:** https://wordpress.org/plugins/header-footer-elementor/
- **Author:** Brainstorm Force
- **Vulnerability Type:** Authenticated Information Disclosure
- **Required Privilege:** Contributor+
- **CVE ID:** CVE-2024-10050

---

## 🧠 Vulnerability Summary

A vulnerability exists in the `Header Footer Elementor` WordPress plugin, versions up to and including `1.6.42`, due to improper access control on the `[hfe_template]` shortcode. This allows **Contributor-level** users to access and render **restricted admin templates** by referencing their internal ID.

This effectively bypasses WordPress’s role-based content visibility model and may lead to sensitive data exposure, design leaks, or enumeration of administrative templates.

---

## 🎯 Impact

- Disclosure of private or admin-only Elementor templates.
- Bypass of WordPress post visibility and permission model.
- Potential exposure of shortcodes, design structures, or sensitive content.
- Privilege escalation vector (visual template snooping).

---

## 🧪 Proof of Concept (PoC)

### 🧷 Pre-requisites:

- WordPress site with `Header Footer Elementor` version 1.6.42 installed.
- Admin has created a **Saved Template** via **Templates > Saved Templates**.
- Contributor account is available.

### 🔬 Steps:

1. Log in as **Contributor**.
2. Create a new **Post** (keep it in “Pending” status).
3. In the post content editor, insert the shortcode:

    ```text
    [hfe_template id="306"]
    ```

    Replace `306` with the actual ID of the saved template created by the admin.

4. Click **Preview**.

### ✅ Expected Result:

The Contributor should not have access to view or render private admin templates.

### ❌ Actual Result:

The private template is rendered in the preview, despite access restrictions.

---

## 🛡️ Mitigation

- Update the plugin to version **1.6.43** or higher.
- The patched version ensures that the `[hfe_template]` shortcode validates user capability before rendering template content.

```bash
# Update via WP-CLI
wp plugin update header-footer-elementor
