require 'spec_helper'

describe Policy::Policy do
  let(:policy) do
    Class.new do
      include Policy::Policy
      def allowed; end
    end
  end

  describe "#call" do
    subject(:call) { policy.call }

    it { should be_instance_of policy }
    it { policy.any_instance.should_receive(:allowed); call }
  end

  describe "#call!" do
    subject(:call!) { policy.call! }

    it { should be_instance_of policy }
    it { policy.any_instance.should_receive(:allowed); call! }

    context "when allowed fails" do
      before do
        policy.any_instance.stub(:message).and_return("Message")
        policy.any_instance.stub(:allowed).and_return(false)
      end

      it { expect { call! }.to raise_error(Policy::PermissionError, "Message") }
    end
  end

  describe ".succeeded?" do
    subject(:policy_object) { policy.new }

    context "is true by default" do
      it { expect(policy_object.succeeded?).to eq(true) }
    end

    context "when succeeded is true" do
      before { policy_object.instance_variable_set(:@succeeded, true) }

      it { expect(policy_object.succeeded?).to eq(true) }
    end

    context "when succeeded is false" do
      before { policy_object.instance_variable_set(:@succeeded, false) }

      it { expect(policy_object.succeeded?).to eq(false) }
    end
  end

  describe ".failed?" do
    subject(:policy_object) { policy.new }

    context "is false by default" do
      it { expect(policy_object.failed?).to eq(false) }
    end

    context "when succeeded is true" do
      before { policy_object.instance_variable_set(:@succeeded, true) }

      it { expect(policy_object.failed?).to eq(false) }
    end

    context "when succeeded is false" do
      before { policy_object.instance_variable_set(:@succeeded, false) }

      it { expect(policy_object.failed?).to eq(true) }
    end
  end

  describe ".fail!" do
    subject(:policy_object) { policy.new }

    it { expect(policy_object.fail!).to eq(false) }

    it "fails the policy" do
      policy_object.fail!
      expect(policy_object.failed?).to eq(true)
    end

    it "sets the message to one passed in" do
      policy_object.fail!("A message")
      expect(policy_object.message).to eq("A message")
    end
  end

  describe ".succeed!" do
    subject(:policy_object) { policy.new }

    it { expect(policy_object.succeed!).to eq(true) }

    it "succeeds the policy" do
      policy_object.succeed!
      expect(policy_object.failed?).to eq(false)
    end
  end

  describe ".context" do
    it { expect(policy.new(message: "Message").context).to eq(message: "Message") }
  end
end