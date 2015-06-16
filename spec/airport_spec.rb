require 'airport'

describe Airport do

  it { is_expected.to respond_to(:landing).with(1).argument }

  it 'has a capacity' do
    expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  describe 'take off' do

    let(:plane){ Plane.new } # refactor with doubles

    before(:each) do
      allow(subject).to receive(:stormy?).and_return false
    end

    it 'releases a plane' do
      subject.landing plane
      subject.requesting_take_off
      expect(subject.empty?).to eq true # to be empty
    end

    it 'instructs a plane to take off' do
      # SETUP
      plane = double :plane, landed?: false, land: nil
      subject.landing plane

      # EXPECTATION ABOUT THE FUTURE
      expect(plane).to receive :take_off

      # EXERCISE
      subject.requesting_take_off
    end

    it 'raises an error message when the airport is empty' do
      expect { subject.requesting_take_off }.to raise_error 'No planes to take off!'
    end

    context 'when weather conditions are stormy' do

      it 'raises an error when plane tries to take off' do
        subject.landing plane

        allow(subject).to receive(:stormy?).and_return true
        expect { subject.requesting_take_off }.to raise_error "It's too stormy to fly!"
      end

    end

  end

  describe 'landing' do

    let(:plane){ Plane.new }

    it 'receives a plane' do
      allow(subject).to receive(:weather) { 4 }
      subject.landing plane
      expect(subject).not_to be_empty
    end

    it 'instructs a plane to land' do
      # Have a go at refactoring this as we did above
      allow(subject).to receive(:weather) { 4 }
      subject.landing plane
      plane.land
      expect(plane).to be_landed
    end

    it 'raises an error when the airport is full' do
      allow(subject).to receive(:weather) { 4 }
      15.times { subject.landing Plane.new }
      expect{ subject.landing plane }.to raise_error 'The airport is full!'
    end

    it 'raises an error when landing a plane that has already landed' do
      allow(subject).to receive(:weather) { 4 }
      subject.landing plane
      expect{subject.landing plane}.to raise_error 'That plane has already landed!'
    end

    context 'when weather conditions are stormy' do
      let(:plane){ Plane.new }

      it 'raises an error when plane tries to land' do
        allow(subject).to receive(:weather) { 10 } # use and_return syntax
        expect{subject.landing plane}.to raise_error 'It\'s too stormy to land!'
      end

    end

  end

  describe 'weather' do

    it 'sets weather status as stormy if number is 5' do
      allow(subject).to receive(:weather) { 10 }
      expect(subject.forecast).to eq 'stormy'
    end

    it 'sets weather status as stormy if number is not 5' do
      allow(subject).to receive(:weather) { 3 }
    end

  end

end
