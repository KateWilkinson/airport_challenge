require 'airport'

describe Airport do

  it { is_expected.to respond_to(:landing).with(1).argument }

  it 'has a capacity' do
    expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  describe 'take off' do

    let (:plane) {double :plane, landed?: nil, land: nil, take_off: nil}

    before(:each) do
      allow(subject).to receive(:stormy?).and_return false
    end

    it 'releases a plane' do
      subject.landing plane
      subject.requesting_take_off
      expect(subject.empty?).to be true
    end

    it 'instructs a plane to take off' do
      plane = double :plane, landed?: false, land: nil
      subject.landing plane
      expect(plane).to receive :take_off
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

    before(:each) do
      allow(subject).to receive(:stormy?).and_return false
    end

    it 'receives a plane' do
      plane = double :plane, landed?: false, land: nil
      subject.landing plane
      expect(subject).not_to be_empty
    end

    it 'instructs a plane to land' do
      plane = double :plane, landed?: false, land: false
      subject.landing plane
      expect(plane.landed?).to be true
    end

    it 'raises an error when the airport is full' do
      plane = double :plane, landed?: false, land:
      15.times { subject.landing Plane.new }
      expect{ subject.landing plane }.to raise_error 'The airport is full!'
    end

    it 'raises an error when landing a plane that has already landed' do
      plane = double :plane, landed?: true
      expect{subject.landing plane}.to raise_error 'That plane has already landed!'
    end

    context 'when weather conditions are stormy' do
      let(:plane){ Plane.new }

      it 'raises an error when plane tries to land' do
        allow(subject).to receive(:stormy?).and_return true
        expect{subject.landing plane}.to raise_error "It's too stormy to land!"
      end

    end

  end

  describe 'weather' do

    it 'sets weather status as stormy if number is 10' do
      allow(subject).to receive(:weather) { 10 }
      expect(subject.forecast).to eq 'stormy'
    end

    it 'sets weather status as stormy if number is not 10' do
      allow(subject).to receive(:weather) { 3 }
    end

  end

end
