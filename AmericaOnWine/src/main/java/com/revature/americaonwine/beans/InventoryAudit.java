package com.revature.americaonwine.beans;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "aow_inventory_audit")
public class InventoryAudit {

	@Id
	@SequenceGenerator(name = "inventory_auditGen", sequenceName = "aow_inventory_audit_seq", allocationSize = 1)
	@GeneratedValue(generator = "inventory_auditGen", strategy = GenerationType.SEQUENCE)
	private int id;
	@Column
	private int old_id;
	private int new_id;
	private String old_name;
	private String new_name;
	private int old_brand_id;
	private int new_brand_id;
	private int old_user_id;
	private int new_user_id;
	private int old_country_id;
	private int new_country_id;
	private int old_type_id;
	private int new_type_id;
	private int old_sub_type_id;
	private int new_sub_type_id;
	private float old_volume;
	private float new_volume;
	private int old_year;
	private int new_year;
	private float old_price;
	private float new_price;
	private LocalDate old_submitted;
	private LocalDate new_submitted;
	private String old_description;
	private String new_description;
	private String old_image_url;
	private String new_image_url;

	public InventoryAudit() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOld_id() {
		return old_id;
	}

	public void setOld_id(int old_id) {
		this.old_id = old_id;
	}

	public int getNew_id() {
		return new_id;
	}

	public void setNew_id(int new_id) {
		this.new_id = new_id;
	}

	public String getOld_name() {
		return old_name;
	}

	public void setOld_name(String old_name) {
		this.old_name = old_name;
	}

	public String getNew_name() {
		return new_name;
	}

	public void setNew_name(String new_name) {
		this.new_name = new_name;
	}

	public int getOld_brand_id() {
		return old_brand_id;
	}

	public void setOld_brand_id(int old_brand_id) {
		this.old_brand_id = old_brand_id;
	}

	public int getNew_brand_id() {
		return new_brand_id;
	}

	public void setNew_brand_id(int new_brand_id) {
		this.new_brand_id = new_brand_id;
	}

	public int getOld_user_id() {
		return old_user_id;
	}

	public void setOld_user_id(int old_user_id) {
		this.old_user_id = old_user_id;
	}

	public int getNew_user_id() {
		return new_user_id;
	}

	public void setNew_user_id(int new_user_id) {
		this.new_user_id = new_user_id;
	}

	public int getOld_country_id() {
		return old_country_id;
	}

	public void setOld_country_id(int old_country_id) {
		this.old_country_id = old_country_id;
	}

	public int getNew_country_id() {
		return new_country_id;
	}

	public void setNew_country_id(int new_country_id) {
		this.new_country_id = new_country_id;
	}

	public int getOld_type_id() {
		return old_type_id;
	}

	public void setOld_type_id(int old_type_id) {
		this.old_type_id = old_type_id;
	}

	public int getNew_type_id() {
		return new_type_id;
	}

	public void setNew_type_id(int new_type_id) {
		this.new_type_id = new_type_id;
	}

	public int getOld_sub_type_id() {
		return old_sub_type_id;
	}

	public void setOld_sub_type_id(int old_sub_type_id) {
		this.old_sub_type_id = old_sub_type_id;
	}

	public int getNew_sub_type_id() {
		return new_sub_type_id;
	}

	public void setNew_sub_type_id(int new_sub_type_id) {
		this.new_sub_type_id = new_sub_type_id;
	}

	public float getOld_volume() {
		return old_volume;
	}

	public void setOld_volume(float old_volume) {
		this.old_volume = old_volume;
	}

	public float getNew_volume() {
		return new_volume;
	}

	public void setNew_volume(float new_volume) {
		this.new_volume = new_volume;
	}

	public int getOld_year() {
		return old_year;
	}

	public void setOld_year(int old_year) {
		this.old_year = old_year;
	}

	public int getNew_year() {
		return new_year;
	}

	public void setNew_year(int new_year) {
		this.new_year = new_year;
	}

	public float getOld_price() {
		return old_price;
	}

	public void setOld_price(float old_price) {
		this.old_price = old_price;
	}

	public float getNew_price() {
		return new_price;
	}

	public void setNew_price(float new_price) {
		this.new_price = new_price;
	}

	public LocalDate getOld_submitted() {
		return old_submitted;
	}

	public void setOld_submitted(LocalDate old_submitted) {
		this.old_submitted = old_submitted;
	}

	public LocalDate getNew_submitted() {
		return new_submitted;
	}

	public void setNew_submitted(LocalDate new_submitted) {
		this.new_submitted = new_submitted;
	}

	public String getOld_description() {
		return old_description;
	}

	public void setOld_description(String old_description) {
		this.old_description = old_description;
	}

	public String getNew_description() {
		return new_description;
	}

	public void setNew_description(String new_description) {
		this.new_description = new_description;
	}

	public String getOld_image_url() {
		return old_image_url;
	}

	public void setOld_image_url(String old_image_url) {
		this.old_image_url = old_image_url;
	}

	public String getNew_image_url() {
		return new_image_url;
	}

	public void setNew_image_url(String new_image_url) {
		this.new_image_url = new_image_url;
	}

	@Override
	public String toString() {
		return "InventoryAudit [id=" + id + ", old_id=" + old_id + ", new_id=" + new_id + ", old_name=" + old_name
				+ ", new_name=" + new_name + ", old_brand_id=" + old_brand_id + ", new_brand_id=" + new_brand_id
				+ ", old_user_id=" + old_user_id + ", new_user_id=" + new_user_id + ", old_country_id=" + old_country_id
				+ ", new_country_id=" + new_country_id + ", old_type_id=" + old_type_id + ", new_type_id=" + new_type_id
				+ ", old_sub_type_id=" + old_sub_type_id + ", new_sub_type_id=" + new_sub_type_id + ", old_volume="
				+ old_volume + ", new_volume=" + new_volume + ", old_year=" + old_year + ", new_year=" + new_year
				+ ", old_price=" + old_price + ", new_price=" + new_price + ", old_submitted=" + old_submitted
				+ ", new_submitted=" + new_submitted + ", old_description=" + old_description + ", new_description="
				+ new_description + ", old_image_url=" + old_image_url + ", new_image_url=" + new_image_url + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + new_brand_id;
		result = prime * result + new_country_id;
		result = prime * result + ((new_description == null) ? 0 : new_description.hashCode());
		result = prime * result + new_id;
		result = prime * result + ((new_image_url == null) ? 0 : new_image_url.hashCode());
		result = prime * result + ((new_name == null) ? 0 : new_name.hashCode());
		result = prime * result + Float.floatToIntBits(new_price);
		result = prime * result + new_sub_type_id;
		result = prime * result + ((new_submitted == null) ? 0 : new_submitted.hashCode());
		result = prime * result + new_type_id;
		result = prime * result + new_user_id;
		result = prime * result + Float.floatToIntBits(new_volume);
		result = prime * result + new_year;
		result = prime * result + old_brand_id;
		result = prime * result + old_country_id;
		result = prime * result + ((old_description == null) ? 0 : old_description.hashCode());
		result = prime * result + old_id;
		result = prime * result + ((old_image_url == null) ? 0 : old_image_url.hashCode());
		result = prime * result + ((old_name == null) ? 0 : old_name.hashCode());
		result = prime * result + Float.floatToIntBits(old_price);
		result = prime * result + old_sub_type_id;
		result = prime * result + ((old_submitted == null) ? 0 : old_submitted.hashCode());
		result = prime * result + old_type_id;
		result = prime * result + old_user_id;
		result = prime * result + Float.floatToIntBits(old_volume);
		result = prime * result + old_year;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InventoryAudit other = (InventoryAudit) obj;
		if (id != other.id)
			return false;
		if (new_brand_id != other.new_brand_id)
			return false;
		if (new_country_id != other.new_country_id)
			return false;
		if (new_description == null) {
			if (other.new_description != null)
				return false;
		} else if (!new_description.equals(other.new_description))
			return false;
		if (new_id != other.new_id)
			return false;
		if (new_image_url == null) {
			if (other.new_image_url != null)
				return false;
		} else if (!new_image_url.equals(other.new_image_url))
			return false;
		if (new_name == null) {
			if (other.new_name != null)
				return false;
		} else if (!new_name.equals(other.new_name))
			return false;
		if (Float.floatToIntBits(new_price) != Float.floatToIntBits(other.new_price))
			return false;
		if (new_sub_type_id != other.new_sub_type_id)
			return false;
		if (new_submitted == null) {
			if (other.new_submitted != null)
				return false;
		} else if (!new_submitted.equals(other.new_submitted))
			return false;
		if (new_type_id != other.new_type_id)
			return false;
		if (new_user_id != other.new_user_id)
			return false;
		if (Float.floatToIntBits(new_volume) != Float.floatToIntBits(other.new_volume))
			return false;
		if (new_year != other.new_year)
			return false;
		if (old_brand_id != other.old_brand_id)
			return false;
		if (old_country_id != other.old_country_id)
			return false;
		if (old_description == null) {
			if (other.old_description != null)
				return false;
		} else if (!old_description.equals(other.old_description))
			return false;
		if (old_id != other.old_id)
			return false;
		if (old_image_url == null) {
			if (other.old_image_url != null)
				return false;
		} else if (!old_image_url.equals(other.old_image_url))
			return false;
		if (old_name == null) {
			if (other.old_name != null)
				return false;
		} else if (!old_name.equals(other.old_name))
			return false;
		if (Float.floatToIntBits(old_price) != Float.floatToIntBits(other.old_price))
			return false;
		if (old_sub_type_id != other.old_sub_type_id)
			return false;
		if (old_submitted == null) {
			if (other.old_submitted != null)
				return false;
		} else if (!old_submitted.equals(other.old_submitted))
			return false;
		if (old_type_id != other.old_type_id)
			return false;
		if (old_user_id != other.old_user_id)
			return false;
		if (Float.floatToIntBits(old_volume) != Float.floatToIntBits(other.old_volume))
			return false;
		if (old_year != other.old_year)
			return false;
		return true;
	}
}
