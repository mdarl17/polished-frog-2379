require 'rails_helper'

RSpec.describe Hospital do
  before(:each) do 
    @grey_sloan = Hospital.create!({name: "Grey Sloan Memorial Hospital"})
    @seaside = Hospital.create!({name: "Seaside Health & Wellness Center"})

    @meredith = Doctor.create!({name: "Meredith Grey", specialty: "General Surgery", education: "Harvard University", hospital_id: @grey_sloan.id})
    @alex = Doctor.create!({name: "Alex Karev", specialty: "Pediatric Surgery", education: "Johns Hopkins University", hospital_id: @grey_sloan.id})
    @miranda = Doctor.create!({name: "Miranda Bailey", specialty: "General Surgery", education: "Stanford University", hospital_id: @seaside.id})
    @mcdreamy = Doctor.create!({name: "Derek 'McDreamy' Shepherd", specialty: "Attending Surgeon", education: "University of Pennsylvania", hospital_id: @seaside.id})

    @katie = Patient.create!({name: "Katie Bryce", age: 24})
    @denny = Patient.create!({name: "Denny Duquette", age: 39})
    @rebecca = Patient.create!({name: "Rebecca Pope", age: 32})
    @zola = Patient.create!({name: "Zola Shepherd", age: 2})

    @merekate= PatientDoctor.create!({patient_id: @katie.id, doctor_id: @meredith.id})
    @denalex = PatientDoctor.create!({patient_id: @denny.id, doctor_id: @alex.id})
    @mirbecca = PatientDoctor.create!({patient_id: @rebecca.id, doctor_id: @miranda.id})
    @zoladeth = PatientDoctor.create!({patient_id: @zola.id, doctor_id: @meredith.id})
    @mcbecca = PatientDoctor.create!({patient_id: @rebecca.id, doctor_id: @mcdreamy.id})
    @mcdenny = PatientDoctor.create!({patient_id: @denny.id, doctor_id: @mcdreamy.id})
  end
  describe "relationships" do 
    it { should have_many :doctors }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "it exists" do 
    it "is created as a Hospital class" do 
      @hospital = Hospital.create!({name: "Seattle Grace"})
      
      expect(@hospital.class).to eq(Hospital)
    end
    
    it "is created with a name attribute" do 
      @hospital = Hospital.create!({name: "Seattle Grace"})
      expect(@hospital.name).to eq("Seattle Grace")
    end
  end
  describe "instance methods" do 
    describe "#sort_by_patient_count" do 
      it "sorts a hospital's doctors in descending order of their patient count" do 
        expect(@grey_sloan.sort_by_patient_count).to eq([@meredith, @alex])
        expect(@seaside.sort_by_patient_count).to eq([@mcdreamy, @miranda])
      end
    end
  end
end