require 'airport'

describe Airport do

  it {is_expected.to respond_to(:landing).with(1).argument }

  it 'has a capacity' do
    expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  describe 'take off' do
    let(:plane){Plane.new}

    it 'releases a plane' do
      allow(subject).to receive(:weather) {4}
      subject.landing plane
      subject.requesting_take_off
      expect(subject.empty?).to eq true
    end

    it 'instructs a plane to take off' do
      allow(subject).to receive(:weather) {4}
      subject.landing plane
      subject.requesting_take_off
      expect(plane).to be_flying
    end

    it 'raises an error message when the airport is empty' do
      expect{subject.requesting_take_off}.to raise_error 'No planes to take off!'
    end

  end

  describe 'landing' do
    let(:plane){Plane.new}

    it 'receives a plane' do
      allow(subject).to receive(:weather) {4}
      subject.landing plane
      expect(subject.empty?).to eq false
    end

    it 'instructs a plane to land' do
      allow(subject).to receive(:weather) {4}
      subject.landing plane
      plane.land
      expect(plane).to be_landed
    end

    it 'raises an error message when the airport is full' do
      allow(subject).to receive(:weather) {4}
      15.times {subject.landing plane}
      expect{subject.landing plane}.to raise_error 'The airport is full!'
    end

  end

  describe 'weather' do

    it 'sets weather status as stormy if number is 5' do
      allow(subject).to receive(:weather) {5}
      expect(subject.forecast).to eq 'stormy'
    end

  end

  describe 'traffic control' do

    let(:plane){Plane.new}

    context 'when weather conditions are stormy' do

      it 'raises an error when plane tries to land' do
        allow(subject).to receive(:weather) {5}
        expect{subject.landing plane}.to raise_error 'It\'s too stormy to land!'
      end

      it 'raises an error when plane tries to take off' do
        subject.landing plane
        allow(subject).to receive(:weather) {5}
        expect{subject.requesting_take_off}.to raise_error 'It\'s too stormy to fly!'
      end

    end
  end

end
